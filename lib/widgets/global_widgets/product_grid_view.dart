import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/utils/network_urls.dart';
import 'package:fclp_app/views/product_details_screen/product_details_view.dart';
import 'package:fclp_app/widgets/global_widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ProductController>(
          builder: (_, productController, __) {
            if (productController.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.themeColor,
                ),
              );
            }
            return GridView.builder(
              shrinkWrap: true,
              primary: false,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                childAspectRatio: 0.7,
                crossAxisSpacing: 7.5,
                mainAxisSpacing: 7.5,
                maxCrossAxisExtent: 220,
              ),
              itemCount: productController.productData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsView(
                            productData: productController.productData[index]),
                      ),
                    ).then((value){
                      productController.resetSelectedProductData();
                    });
                  },
                  child: ProductCard(
                      productImg:
                          "${NetworkUrls.storageBaseUrl}${productController.productData[index].image.toString()}",
                      productTitle:
                          productController.productData[index].name.toString(),
                      isFavorite: false,
                      toggleFavorite: () {},
                      productOriginalPrice:
                          productController.productData[index].price.toString(),
                      productDiscountPrice: productController
                          .productData[index].discountPrice
                          .toString()),
                );
              },
            );
          },
        ));
  }
}
