import 'package:cached_network_image/cached_network_image.dart';
import 'package:fclp_app/Controllers/bottom_navbar_controller.dart';
import 'package:fclp_app/Controllers/cart_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/color_palette.dart';
import '../../utils/network_urls.dart';

class CartProductCard extends StatelessWidget {
  final CartController cartController;
  final Size size;

  const CartProductCard(
      {super.key, required this.cartController, required this.size});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
          itemCount: cartController.cartList.length,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl:
                              "${NetworkUrls.storageBaseUrl}${cartController.cartList[index].image.toString()}",
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fitHeight)),
                            );
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.3,
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                cartController.cartList[index].name.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              "\u09F3\t${cartController.getProductTotalPrice(cartController.cartList[index].quantity.toString(), cartController.cartList[index].price.toString())}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              splashColor: AppColors.transparent,
                              onTap: () {
                                deleteFromCart(
                                  index: index,
                                  productId:
                                      cartController.cartList[index].itemId!,
                                  cartController: cartController,
                                  context: context,
                                );
                              },
                              child: Icon(
                                Icons.delete_outlined,
                                size: 25,
                                color: AppColors.themeColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: AppColors.secondaryThemeColor,
                              borderRadius: BorderRadius.circular(6)),
                          alignment: Alignment.center,
                          child: InkWell(
                            splashColor: AppColors.transparent,
                            onTap: () {
                              if (cartController.cartList[index].quantity ==
                                  "1") {
                                return;
                              }
                              updateCart(
                                context: context,
                                cartController: cartController,
                                index: index,
                                willIncrement: false,
                              );
                            },
                            child: Icon(
                              Icons.remove,
                              color: AppColors.themeColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            cartController.cartList[index].quantity.toString()),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: AppColors.secondaryThemeColor,
                              borderRadius: BorderRadius.circular(6)),
                          alignment: Alignment.center,
                          child: InkWell(
                            splashColor: AppColors.transparent,
                            onTap: (){
                              updateCart(
                                context: context,
                                cartController: cartController,
                                index: index,
                                willIncrement: true,
                              );
                            },
                            child: Icon(
                              Icons.add,
                              color: AppColors.themeColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                if (cartController.selectedProductIndex == index)
                  SizedBox(
                    width: size.width * 0.8,
                    child: LinearProgressIndicator(
                      color: AppColors.themeColor,
                      minHeight: 1,
                    ),
                  ),
              ],
            ),
          ),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
        ),
      ),
    );
  }

  Future<void> deleteFromCart(
      {required int index,
      required int productId,
      required CartController cartController,
      required BuildContext context}) async {
    bool status = await cartController.deleteFromCart(
        context.read<ProfileController>().token, productId, index);
    if (status && context.mounted) {
      snackBarMessage(
          context: context, message: AppStrings.removeFromCartSuccessMessage);
      context.read<BottomNavbarController>().refreshNavbar();
      return;
    }
    if (context.mounted) {
      warningDialog(
          context: context,
          warningDescription: AppStrings.removeFromCartFailureMessage,
          message: AppStrings.removeFromCartFailureTitle);
    }
  }

  Future<void> updateCart(
      {required BuildContext context,
      required CartController cartController,
      required int index,
      required bool willIncrement}) async {
    late BuildContext alertContext;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          alertContext = context;
          return const AlertDialog(
            title: Text("Testing"),
            content: Text("Loading"),
          );
        });
    bool status = await cartController.updateCart(
        index, context.read<ProfileController>().token, willIncrement);
    if (context.mounted) {
      Navigator.pop(alertContext);
      if (!status) {
        snackBarMessage(
            context: context,
            message: AppStrings.cartProductQuantityUpdateFailedMessage);
      }
    }
  }
}
