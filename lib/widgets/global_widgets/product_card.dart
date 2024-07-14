import 'package:cached_network_image/cached_network_image.dart';
import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 20,
              offset: const Offset(0, 8))
        ],
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: CachedNetworkImage(
                  imageUrl: productImg,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(13),
                            topLeft: Radius.circular(13)),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.fitHeight),
                      ),
                    );
                  },
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: AppColors.themeColor,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: (productDiscountPrice != "0.00")
                      ? const EdgeInsets.only(
                          left: 8,
                          top: 5,
                        )
                      : const EdgeInsets.only(
                          left: 8,
                          top: 20,
                        ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 2,
                          productTitle,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  (productDiscountPrice != "0.00")
                                      ? "ট\t$productDiscountPrice"
                                      : "ট\t$productOriginalPrice",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  (productDiscountPrice != "0.00")
                                      ? productOriginalPrice
                                      : "",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 11.0,
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
                        if (productDiscountPrice != "0.00")
                          Row(
                            children: [
                              Text(
                                "${context.read<ProductController>().getDiscountPercentage(productDiscountPrice, productOriginalPrice)}%",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.red.shade300,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.discount_outlined,
                                color: Colors.red.shade300,
                                size: 20,
                              )
                            ],
                          )
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
                color: isFavorite ? AppColors.red : AppColors.themeColor,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
