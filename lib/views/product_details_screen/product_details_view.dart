import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/utils/network_urls.dart';
import 'package:fclp_app/views/cart_screen/cart_screen.dart';
import 'package:fclp_app/views/product_details_screen/product_details_widgets/product_description_section.dart';
import 'package:fclp_app/views/product_details_screen/product_details_widgets/product_details_footer.dart';
import 'package:fclp_app/views/product_details_screen/product_details_widgets/product_header_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product_model/product_data.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.productData,
  });

  final ProductData productData;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int page = 1;
  final ScrollController _scrollController = ScrollController();
  late final ProductData productData;

  @override
  void initState() {
    productData = widget.productData;
    _scrollController.addListener(_scrollListener);
    _loadSpecificProductData(page, widget.productData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                EvaIcons.arrowIosBack,
                                size: 28,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              AppStrings.productDetailsHeaderText,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 17),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CartScreen(),
                                  ),
                                );
                              },
                              child: Icon(
                                EvaIcons.shoppingCartOutline,
                                size: 30,
                                color: AppColors.themeColor,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Hero(
                    tag: productData.name.toString(),
                    child: CachedNetworkImage(
                      imageUrl:
                          "${NetworkUrls.storageBaseUrl}${productData.image.toString()}",
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          height: 320,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain)),
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    child: Column(
                      children: [
                        ProductHeaderSection(productData: productData),
                        const SizedBox(
                          height: 10,
                        ),
                        ProductDescriptionSection(productData: productData),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ProductDetailsFooter(productData: productData)
        ],
      ),
    ));
  }

  Future<void> _loadSpecificProductData(int page, ProductData product,
      {bool? fromScrollListener}) async {
    if (fromScrollListener != null && mounted) {
      await context.read<ProductController>().loadSpecificProductData(
          product.categoryId.toString(),
          context.read<ProfileController>().token,
          page,currentProductId: productData.id!);
      return;
    }
    context.read<ProductController>().specificProductData.clear();
    await context.read<ProductController>().loadSpecificProductData(
        product.categoryId.toString(),
        context.read<ProfileController>().token,
        page,
        currentProductId: productData.id!);
  }

  void _scrollListener() {
    if (!context.read<ProductController>().isRelatedProductFetching &&
        context.read<ProductController>().relatedProductNextPageAvailable) {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page += 1;
        _loadSpecificProductData(page, widget.productData,
            fromScrollListener: true);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
