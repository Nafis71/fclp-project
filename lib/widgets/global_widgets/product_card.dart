import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.productImg,
    required this.productTitle,
    required this.isFavorite,
    required this.toggleFavorite,
    required this.productOriginalPrice,
    required this.productDiscountPrice,
  });

  final String productImg;
  final String productTitle;
  final String productOriginalPrice;
  final String productDiscountPrice;
  final bool isFavorite;
  final VoidCallback toggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 120,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(productImg),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 5,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productTitle,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "ট\t$productDiscountPrice",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 17.0,
                                color: AppColors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              productOriginalPrice,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: AppColors.grey,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: AppColors.red,
                                decorationThickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 10,
            top: 10,
            child: InkWell(
              onTap: toggleFavorite,
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_outline,
                color: isFavorite ? AppColors.red : AppColors.green,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
