import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/utils/assets_pahts.dart';
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
            return GridView.builder(
              shrinkWrap: true,
              primary: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.65,
                crossAxisCount: 2,
                crossAxisSpacing: 10.5,
                mainAxisSpacing: 0.5,
              ),
              itemCount: viewModel.productData.length,
              itemBuilder: (context, index) {
                if (!viewModel.isLoading) {
                  return ProductCard(
                      productImg:
                          "https://fclpbd.xyz/public/storage/${viewModel.productData[index].image.toString()}",
                      productTitle: viewModel.productData[index].name.toString(),
                      isFavorite: false,
                      toggleFavorite: () {},
                      productOriginalPrice: viewModel.productData[index].price.toString(),
                      productDiscountPrice: viewModel.productData[index].discountPrice.toString());
                }
                return const Center(child: CircularProgressIndicator(color: AppColors.themeColor,),);
              },
            );
          },
        ));
  }
}
