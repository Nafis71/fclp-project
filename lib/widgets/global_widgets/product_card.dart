import 'package:cached_network_image/cached_network_image.dart';
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
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: CachedNetworkImage(
                 imageUrl: productImg,
                  imageBuilder: (context,imageProvider){
                   return Container(
                     width: double.maxFinite,
                     decoration: BoxDecoration(
                         borderRadius: const BorderRadius.only(
                           topLeft: Radius.circular(8),
                           topRight: Radius.circular(8),
                         ),
                         image: DecorationImage(
                             image: imageProvider,fit: BoxFit.cover
                         ),
                     ),
                   );
                  },
                  placeholder: (context,url) => const CircularProgressIndicator(color: AppColors.themeColor,),
                )
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding:  (productDiscountPrice != "0.00") ? const EdgeInsets.only(
                    left: 8,
                    top: 20,
                  ) : const EdgeInsets.only(
                    left: 8,
                    top: 40,
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
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  (productDiscountPrice != "0.00") ? "ট\t$productDiscountPrice" :"ট\t$productOriginalPrice",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  (productDiscountPrice != "0.00") ? productOriginalPrice : "",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12.0,
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
                        if(productDiscountPrice != "0.00") const Row(
                          children: [
                            Text(
                              "50%",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.discount_outlined,color: Colors.red,)
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
