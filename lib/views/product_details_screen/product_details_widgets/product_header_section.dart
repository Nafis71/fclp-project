import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/models/product_model/product_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/color_palette.dart';

class ProductHeaderSection extends StatelessWidget {
  final ProductData productData;

  const ProductHeaderSection({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    ProductController productController = context.read<ProductController>();
    double productPrice = 0;
    if (productData.discountPrice != "0.00") {
      productPrice = double.parse(productData.discountPrice.toString());
    } else {
      productPrice = double.parse(productData.price.toString());
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          direction: Axis.horizontal,
          children: [
            Text(
              productData.name.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 100,
              child: Text(
                productData.category!.name.toString(),
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Row(
              children: [
                InkWell(
                  splashColor: AppColors.transparent,
                  onTap: () {
                    productController.decreaseProductQuantity(productPrice);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: AppColors.secondaryThemeColor,
                        borderRadius: BorderRadius.circular(6)),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.remove,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Consumer<ProductController>(
                    builder: (_, productController, __) {
                  return Text(
                      productController.selectedProductQuantity.toString());
                }),
                const SizedBox(
                  width: 8,
                ),
                InkWell(
                  splashColor: AppColors.transparent,
                  onTap: () {
                    int productQuantity =
                        int.parse(productData.quantity.toString());
                    if (productController.selectedProductQuantity >=
                        productQuantity) {
                      debugPrint("limit exceeded");
                      return;
                    }
                    productController.increaseProductQuantity(productPrice);
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: AppColors.secondaryThemeColor,
                        borderRadius: BorderRadius.circular(6)),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
