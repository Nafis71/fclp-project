import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/Controllers/cart_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/utils/network_urls.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: customAppBar(title: "My Cart"),
      body: Consumer<CartController>(builder: (_, cartController, __) {
        if (cartController.cartList.isEmpty) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.themeColor,
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                  itemCount: cartController.cartList.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
                    child: Row(
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
                                    cartController.cartList[index].name
                                        .toString(),
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "\u09F3\t${getProductTotalPrice(cartController.cartList[index].quantity.toString(), cartController.cartList[index].price.toString())}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  Icons.delete_outlined,
                                  size: 25,
                                  color: AppColors.themeColor,
                                )
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
                              child: Icon(
                                Icons.remove,
                                color: AppColors.themeColor,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("1"),
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
                              child: Icon(
                                Icons.add,
                                color: AppColors.themeColor,
                              ),
                            ),
                          ],
                        )
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
            ),
            Container(
              height: 100,
              width: size.width,
              decoration: BoxDecoration(
                  color: AppColors.secondaryThemeColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              alignment: Alignment.center,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.grey.shade600),
                        ),
                        Text(
                          "\u09F3\t2000",
                          style: Theme.of(context).textTheme.titleLarge,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      width: size.height * 0.2,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "এখন কেনুন",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  double getProductTotalPrice(String quantity, String unitPrice) {
    int productQuantity = int.parse(quantity);
    double productUnitPrice = double.parse(unitPrice);
    return productUnitPrice * productQuantity;
  }
}
