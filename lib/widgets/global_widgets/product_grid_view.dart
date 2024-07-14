import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/product_details_view.dart';
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
          builder: (_, viewModel, __) {
            if (viewModel.isLoading) {
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
              itemCount: viewModel.productData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsView(
                            productData: viewModel.productData[index]),
                      ),
                    );
                  },
                  child: ProductCard(
                      productImg:
                          "https://fclpbd.xyz/public/storage/${viewModel.productData[index].image.toString()}",
                      productTitle:
                          viewModel.productData[index].name.toString(),
                      isFavorite: false,
                      toggleFavorite: () {},
                      productOriginalPrice:
                          viewModel.productData[index].price.toString(),
                      productDiscountPrice: viewModel
                          .productData[index].discountPrice
                          .toString()),
                );
              },
            );
          },
        ));
  }
}
