import 'package:fclp_app/Controllers/order_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../Controllers/cart_controller.dart';
import '../Controllers/product_controller.dart';
import '../Controllers/profile_controller.dart';

class PrefetchService {
  static Future<void> loadCartData(BuildContext context) async {
    if (context.read<CartController>().cartList.isNotEmpty) {
      return;
    }
    await context
        .read<CartController>()
        .loadCartData(context.read<ProfileController>().token);
  }

  static Future<void> loadProductData(int page, BuildContext context,
      {bool? fromScrollListener}) async {
    if (context.read<ProductController>().productData.isEmpty) {
      await context
          .read<ProductController>()
          .loadProductData(page, context.read<ProfileController>().token);
    }
    if (fromScrollListener != null && context.mounted) {
      await context
          .read<ProductController>()
          .loadProductData(page, context.read<ProfileController>().token);
    }
  }

  static Future<void> loadOrderList(BuildContext context) async {
    if (context.read<OrderController>().orderList.isNotEmpty) {
      return;
    }
    await context
        .read<OrderController>()
        .loadOrderList(context.read<ProfileController>().token);
  }
}