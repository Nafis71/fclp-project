import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/utils/network_urls.dart';
import 'package:fclp_app/views/product_details_screen/product_details_view.dart';
import 'package:fclp_app/views/home_screen/home_product_widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridView extends StatelessWidget {
  final String? categoryId;
  const ProductGridView({super.key,this.categoryId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<ProductController>(
        builder: (_, productController, __) {
          if(categoryId != null){
            if(productController.isCategorialProductFetching){
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
                childAspectRatio: 0.45,
                crossAxisSpacing: 7.5,
                mainAxisSpacing: 7.5,
                maxCrossAxisExtent: 220,
              ),
              itemCount: productController.specificProductData.length,
              itemBuilder: (context, index) {
                return product(context, productController, index);
              },
            );
          }
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
              childAspectRatio: 0.5,
              crossAxisSpacing: 7.5,
              mainAxisSpacing: 7.5,
              maxCrossAxisExtent: 220,
            ),
            itemCount: productController.productData.length,
            itemBuilder: (context, index) {
              return product(context, productController, index);
            },
          );
        },
      ),
    );
  }

  Widget product(BuildContext context,ProductController productController,int index){
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if(categoryId!= null){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsView(
                  productData: productController.specificProductData[index]),
            ),
          ).then((value) {
            productController.resetSelectedProductData();
          });
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsView(
                productData: productController.productData[index]),
          ),
        ).then((value) {
          productController.resetSelectedProductData();
        });
      },
      child: ProductCard(
        product: (categoryId == null) ? productController.productData[index] : productController.specificProductData[index],
        productController: productController,
        isCategorial: (categoryId == null) ? null : true,
      ),
    );
  }
}
