import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/models/product_model/product_data.dart';
import 'package:fclp_app/screens/home_screen/home_product_widget/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_palette.dart';

class ProductDescriptionSection extends StatelessWidget {
  final ProductData productData;

  const ProductDescriptionSection({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "বর্ণনা",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: AppColors.themeColor),
        ),
        Consumer<ProductController>(builder: (_, productController, __) {
          return Text(
            textAlign: TextAlign.justify,
            overflow: (productController.willShowMoreProductDescription)
                ? null
                : TextOverflow.ellipsis,
            maxLines:
                (productController.willShowMoreProductDescription) ? null : 8,
            productData.description.toString(),
            style: TextStyle(color: Colors.grey.shade600),
          );
        }),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.33,
              height: 40,
              child: Consumer<ProductController>(
                  builder: (_, productController, __) {
                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    elevation: 5,
                    side: BorderSide(color: AppColors.secondaryThemeColor),
                  ),
                  onPressed: () {
                    productController.toggleWillShowMoreProductDescription();
                  },
                  child: Text(
                    (productController.willShowMoreProductDescription)
                        ? "কম দেখুন"
                        : "আরো দেখুন",
                    style: TextStyle(color: AppColors.themeColor, fontSize: 13),
                  ),
                );
              }),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Consumer<ProductController>(builder: (_, productController, __) {
          if (!productController.isRelatedProductFetching) {
            return Text(
              "আরো পণ্য দেখুন",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.themeColor),
            );
          }
          return const SizedBox.shrink();
        }),
        ProductGridView(
          categoryId: productData.categoryId,
        )
      ],
    );
  }
}
