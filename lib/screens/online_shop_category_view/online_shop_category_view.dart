import 'package:cached_network_image/cached_network_image.dart';
import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/screens/home_screen/home_product_widget/product_grid_view.dart';
import 'package:fclp_app/screens/product_view.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/network_urls.dart';

class OnlineShopCategoryView extends StatefulWidget {
  const OnlineShopCategoryView({super.key});

  @override
  State<OnlineShopCategoryView> createState() => _OnlineShopCategoryViewState();
}

class _OnlineShopCategoryViewState extends State<OnlineShopCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<ProductController>(builder: (_, productController, __) {
          return GridView.builder(
            itemCount: productController.categoryList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  ProductView(categoryId: productController.categoryList[index].id.toString()),
                    ),
                  );
                },
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 250,
                      width: 150,
                      child: FittedBox(
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  "${NetworkUrls.storageBaseUrl}${productController.categoryList[index].image.toString()}",fit: BoxFit.cover,width: 100,
                              placeholder: (context, _) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.themeColor,
                                  ),
                                );
                              },
                            ),
                            Text(
                              productController.categoryList[index].name!,
                              style:  Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
