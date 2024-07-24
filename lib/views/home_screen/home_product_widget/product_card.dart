import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/Controllers/bottom_navbar_controller.dart';
import 'package:fclp_app/Controllers/cart_controller.dart';
import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/models/product_model/product_data.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/utils/network_urls.dart';
import 'package:fclp_app/views/product_details_screen/product_details_view.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final ProductData product;
  final ProductController productController;
  final bool? isCategorial;

  const ProductCard(
      {super.key,
      required this.product,
      required this.productController,
      this.isCategorial});

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
              tag: (isCategorial == null)
                  ? product.name.toString()
                  : product.image.toString(),
              child: CachedNetworkImage(
                imageUrl: "${NetworkUrls.storageBaseUrl}${product.image}",
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
              padding: (product.discountPrice != "0.00")
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
                    product.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              (product.discountPrice != "0.00")
                                  ? "\u09F3\t${product.discountPrice}"
                                  : "\u09F3\t${product.price}",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              (product.discountPrice != "0.00")
                                  ? product.price.toString()
                                  : "",
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.grey,
                                    fontSize: 11,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: Colors.red,
                                  ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (product.discountPrice != "0.00")
                                Row(
                                  children: [
                                    Text(
                                      "${context.read<ProductController>().getDiscountPercentage(product.discountPrice.toString(), product.price.toString())}%",
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
                              (!product.isProductAddedToCart)
                                  ? InkWell(
                                      splashColor: AppColors.transparent,
                                      onTap: () {
                                        if (isCategorial == null) {
                                          addToCart(context);
                                        } else {
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailsView(
                                                productData: product,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: productCartButton(
                                          icon: Icons
                                              .shopping_cart_checkout_rounded,
                                          bodyText: "Add"))
                                  : productCartButton(
                                      icon: Icons.done, bodyText: "Added")
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

  Widget productCartButton({required IconData icon, required String bodyText}) {
    return Container(
      height: 30,
      width: 80,
      margin: const EdgeInsets.only(left: 4, right: 6, bottom: 8, top: 5),
      decoration: BoxDecoration(
        color: AppColors.secondaryThemeColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          (isCategorial == null)
              ? Icon(
                  icon,
                  color: AppColors.themeColor,
                )
              : Icon(
                  EvaIcons.shoppingBagOutline,
                  color: AppColors.themeColor,
                ),
          Text(
            (isCategorial == null) ? bodyText : "View",
            style: TextStyle(
                color: AppColors.themeColor, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> addToCart(BuildContext context) async {
    bool status = await productController.addToCart(
        context.read<ProfileController>().token,
        product,
        context.read<CartController>());
    if (status && context.mounted) {
      snackBarMessage(
          context: context, message: AppStrings.addToCartSuccessMessage);
      product.isProductAddedToCart = true;
      productController.productAddedFromCard();
      context.read<BottomNavbarController>().refreshNavbar();
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
