import 'package:fclp_app/Controllers/cart_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/screens/cart_screen/cart_product_card.dart';
import 'package:fclp_app/screens/cart_screen/cart_screen_bottom_layout.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      appBar: customAppBar(title: "My Cart", context),
      body: Consumer<CartController>(builder: (_, cartController, __) {
        if (cartController.cartList.isEmpty) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SvgPicture.asset(
                    AssetsPaths.emptyCart,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    AppStrings.emptyCartText,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 15),
                  ),
                ],
              ),
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CartProductCard(cartController: cartController, size: size),
            CartScreenBottomLayout(
              size: size,
              cartController: cartController,
            ),
          ],
        );
      }),
    );
  }
}
