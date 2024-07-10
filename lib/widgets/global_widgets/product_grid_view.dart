import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/views/product_details_view.dart';
import 'package:fclp_app/widgets/global_widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Provider.of<ProductController>(context);

    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1.5,
        mainAxisSpacing: 3.0,
      ),
      itemCount: productController.productData.length,
      itemBuilder: (context, index) {
        final product = productController.productData[index];

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsView(productIndex: index),
              ),
            );
          },
          child: ProductCard(
            productImg: product.img,
            productTitle: product.title,
            productOriginalPrice: product.originalPrice.toString(),
            productDiscountPrice:
                productController.calculateDiscountedPrice(product).toString(),
            isFavorite: product.isFavorite,
            toggleFavorite: () =>
                productController.toggleFavoriteStatus(product),
          ),
        );
      },
    );
  }
}
