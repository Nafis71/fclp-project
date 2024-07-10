import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/Controllers/auth_controller.dart';
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
      ],
      child: const FCLP(),
    ),
  );
}
