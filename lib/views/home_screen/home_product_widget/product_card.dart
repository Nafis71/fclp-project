import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/models/product_model/product_data.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/utils/network_urls.dart';
import 'package:fclp_app/views/product_details_screen/product_details_view.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductData product;
  final ProductController productController;
  final bool? isCategorial;

  const ProductCard(
      {super.key,
      required this.product,
      required this.productController,
      this.isCategorial});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 20,
              offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: CachedNetworkImage(
              imageUrl: "${NetworkUrls.storageBaseUrl}${product.image}",
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(13),
                        topLeft: Radius.circular(13)),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.fitHeight),
                  ),
                );
              },
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: AppColors.themeColor,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: (product.discountPrice != "0.00")
                  ? const EdgeInsets.only(
                      left: 8,
                      top: 5,
                    )
                  : const EdgeInsets.only(
                      left: 8,
                      top: 5,
                    ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    maxLines: 2,
                    product.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              (product.discountPrice != "0.00")
                                  ? "\u09F3\t${product.discountPrice}"
                                  : "\u09F3\t${product.price}",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.themeColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              (product.discountPrice != "0.00")
                                  ? product.price.toString()
                                  : "",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 11.0,
                                color: AppColors.grey,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: AppColors.red,
                                decorationThickness: 2,
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (product.discountPrice != "0.00")
                                Row(
                                  children: [
                                    Text(
                                      "${context.read<ProductController>().getDiscountPercentage(product.discountPrice.toString(), product.price.toString())}%",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.red.shade300,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.discount_outlined,
                                      color: Colors.red.shade300,
                                      size: 22,
                                    )
                                  ],
                                ),
                              InkWell(
                                splashColor: AppColors.transparent,
                                onTap: () {
                                  if (isCategorial == null) {
                                    addToCart(context);
                                  } else {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetailsView(
                                          productData: product,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  height: 30,
                                  width: 80,
                                  margin: const EdgeInsets.only(
                                      left: 4, right: 6, bottom: 8, top: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryThemeColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      (isCategorial == null)
                                          ? Icon(
                                              EvaIcons.shoppingCartOutline,
                                              color: AppColors.themeColor,
                                            )
                                          : Icon(
                                              EvaIcons.shoppingBagOutline,
                                              color: AppColors.themeColor,
                                            ),
                                      Text(
                                        (isCategorial == null) ? "Add" : "View",
                                        style: TextStyle(
                                            color: AppColors.themeColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addToCart(BuildContext context) async {
    bool status = await productController.addToCart(
        context.read<ProfileController>().token, product);
    if (status && context.mounted) {
      snackBarMessage(
          context: context, message: AppStrings.addToCartSuccessMessage);
      return;
    }
    if (context.mounted) {
      warningDialog(
          context: context,
          warningDescription: AppStrings.addToCartFailureMessage,
          message: AppStrings.addToCartFailureTitle);
    }
  }
}
