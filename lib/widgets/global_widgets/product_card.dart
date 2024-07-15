import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Hero(
              tag: productTitle,
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
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: (productDiscountPrice != "0.00")
                  ? const EdgeInsets.only(
                      left: 8,
                      top: 5,
                    )
                  : const EdgeInsets.only(
                      left: 8,
                      top: 5,
                    ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    maxLines: 2,
                    productTitle,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              (productDiscountPrice != "0.00")
                                  ? "\u09F3\t$productDiscountPrice"
                                  : "\u09F3\t$productOriginalPrice",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.themeColor,
                                fontWeight: FontWeight.w700,
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
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                      size: 22,
                                    )
                                  ],
                                ),
                              Container(
                                height: 30,
                                width: 80,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 2, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryThemeColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child:  Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(EvaIcons.shoppingCartOutline,color: AppColors.themeColor,),
                                    Text(
                                      "Add",
                                      style: TextStyle(
                                        color: AppColors.themeColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
