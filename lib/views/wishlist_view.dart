import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistView extends StatefulWidget {
  const WishlistView({super.key});

  @override
  State<WishlistView> createState() => _WishlistViewState();
}

class _WishlistViewState extends State<WishlistView> {
  @override
  Widget build(BuildContext context) {
    final productWishListController = Provider.of<ProductController>(context);

    return Scaffold(
      appBar: customAppBar(),
      body: productWishListController.isWishlistEmpty()
          ? Center(
              child: buildEmptyWidget(
                context: context,
                message: "আপনার উইস লিস্টে কিছু নেই।",
              ),
            )
          : ListView.builder(
              itemCount: productWishListController.wishList.length,
              itemBuilder: (context, index) {
                final product = productWishListController.wishList[index];

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            image: DecorationImage(
                              image: NetworkImage(product.img),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: AppColors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "ট\t${product.discountPrice}",
                                    ),
                                    const TextSpan(text: "\t\t"),
                                    TextSpan(
                                      style: const TextStyle(
                                        color: AppColors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: AppColors.red,
                                        decorationThickness: 2,
                                      ),
                                      text: product.originalPrice.toString(),
                                    ),
                                  ],
                                ),
                              ),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.percent_sharp,
                                    size: 20,
                                    color: AppColors.green,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    "Free Delivery",
                                    style: TextStyle(
                                      color: AppColors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            productWishListController.removeToWishlist(product);
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: AppColors.red,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
