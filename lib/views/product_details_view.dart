import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/models/entities/product_model.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/utils/size_config.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.productIndex,
  });

  final int productIndex;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);
    final ProductModel product =
        productController.productData[widget.productIndex];
    final bool isShopping = product.isShopping;

    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(product.img),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: AppColors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    children: [
                      TextSpan(
                        text:
                            "৳ ${productController.calculateDiscountedPrice(product).toStringAsFixed(2)}",
                      ),
                      const TextSpan(text: "\t\t"),
                      TextSpan(
                        style: const TextStyle(
                          color: AppColors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.red,
                          decorationThickness: 2,
                        ),
                        text: "৳ ${product.originalPrice.toString()}",
                      ),
                    ],
                  ),
                ),
                Text(
                  "(discount ${product.discountPrice.toString()}%)",
                  style: const TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'পণ্যের বিবরণ',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    productController.addToCart(
                      widget.productIndex,
                      product,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isShopping == false ? AppColors.red : AppColors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fixedSize: Size.fromWidth(SizeConfig.screenWidth! / 2.4),
                  ),
                  child: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isShopping == false
                              ? Icons.shopping_cart_outlined
                              : Icons.shopping_cart,
                          size: 30,
                          color: AppColors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isShopping == false ? "কার্টে যুক্ত" : "যুক্ত হয়েছে",
                          style: const TextStyle(
                            color: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              product.description,
              style: const TextStyle(
                color: AppColors.green,
                fontSize: 17,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'প্রয়োজনীয় পণ্য',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const ProductGridView(),
          ],
        ),
      ),
    );
  }
}
