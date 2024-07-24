import 'package:cached_network_image/cached_network_image.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/Controllers/cart_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/utils/network_urls.dart';
import 'package:fclp_app/views/cart_screen/cart_product_card.dart';
import 'package:fclp_app/views/cart_screen/cart_screen_bottom_layout.dart';
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
            CartProductCard(cartController: cartController, size: size),
            CartScreenBottomLayout(size: size),
          ],
        );
      }),
    );
  }
}
