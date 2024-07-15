import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/models/product_model/product_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/color_palette.dart';

class ProductDetailsFooter extends StatelessWidget {
  final ProductData productData;

  const ProductDetailsFooter({super.key, required this.productData});

  @override
  Widget build(BuildContext context) {
    if (productData.discountPrice != "0.00") {
      context
          .read<ProductController>()
          .setProductPrice(double.parse(productData.discountPrice.toString()));
    } else {
      context
          .read<ProductController>()
          .setProductPrice(double.parse(productData.price.toString()));
    }

    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.secondaryThemeColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          )),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Consumer<ProductController>(
                    builder: (_, productController, __) {
                  return Text(
                    "\u09F3\t${productController.selectedProductPrice}",
                    style: TextStyle(
                      color: AppColors.themeColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.39,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "কার্টে যোগ করুন",
                  style: TextStyle(fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
