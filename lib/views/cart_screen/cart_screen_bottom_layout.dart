import 'package:fclp_app/Controllers/cart_controller.dart';
import 'package:fclp_app/views/delivery_confirmation_screen/delivery_details_view.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/color_palette.dart';

class CartScreenBottomLayout extends StatelessWidget {
  final Size size;

  const CartScreenBottomLayout({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: size.width,
      decoration: BoxDecoration(
          color: AppColors.secondaryThemeColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
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
                  "\u09F3\t${context.read<CartController>().totalCartPrice}",
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ),
            SizedBox(
              height: 50,
              width: size.height * 0.2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeliveryDetailsView()));
                },
                child: Text(
                  "এখন কেনুন",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
