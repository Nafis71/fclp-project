import 'package:device_preview/device_preview.dart';
import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/Controllers/auth_controller.dart';
import 'package:fclp_app/Controllers/bottom_navbar_controller.dart';
import 'package:fclp_app/Controllers/cart_controller.dart';
import 'package:fclp_app/Controllers/notification_controller.dart';
import 'package:fclp_app/Controllers/order_controller.dart';
import 'package:fclp_app/Controllers/product_category_view_controller.dart';
import 'package:fclp_app/Controllers/product_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileController()),
        ChangeNotifierProvider(create: (context) => AirTicketController()),
        ChangeNotifierProvider(
            create: (context) => ProdudctCategoryViewController()),
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => CartController()),
        ChangeNotifierProvider(create: (context) => BottomNavbarController()),
        ChangeNotifierProvider(create: (context) => OrderController()),
        ChangeNotifierProvider(create: (context) => NotificationController()),
      ],
      child: DevicePreview(builder: (_)=>const FCLP(),),
    ),
  );
}
