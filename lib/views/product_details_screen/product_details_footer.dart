import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/models/product_model/product_data.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
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
              child: Consumer<ProductController>(
                  builder: (_, productController, __) {
                if (productController.isProductAddedToCart) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.done,
                        size: 30,
                        color: AppColors.themeColor,
                      ),
                      Text("কার্টে যোগ হয়েছে"),
                    ],
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    addToCart(productController, context);
                  },
                  child: const Text(
                    "কার্টে যোগ করুন",
                    style: TextStyle(fontSize: 13),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addToCart(
      ProductController productController, BuildContext context) async {
    bool status = await productController.addToCart(
        context.read<ProfileController>().token, productData);
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
