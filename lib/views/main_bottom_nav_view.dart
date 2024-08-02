import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/Controllers/bottom_navbar_controller.dart';
import 'package:fclp_app/Controllers/cart_controller.dart';
import 'package:fclp_app/Controllers/notification_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/air_ticket_booking_view/air_ticket_view.dart';
import 'package:fclp_app/views/cart_screen/cart_screen.dart';
import 'package:fclp_app/views/home_screen/home_view.dart';
import 'package:fclp_app/views/orderlist_screen/order_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class MainBottomNavView extends StatefulWidget {
  const MainBottomNavView({super.key});

  @override
  State<MainBottomNavView> createState() => _MainBottomNavViewState();
}

class _MainBottomNavViewState extends State<MainBottomNavView> {
  late Timer timer;
  final List<Widget> _screen = [
    const HomeView(),
    const AirTicketView(),
    const CartScreen(),
    const OrderListScreen()
  ];
  @override
  void initState() {
    initiateNotificationService();
    super.initState();
  }
  void initiateNotificationService(){
    timer = Timer.periodic(const Duration(seconds: 30), (time){
      context.read<NotificationController>().getAllNotification(context.read<ProfileController>().token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          index: context.watch<BottomNavbarController>().navBarIndex,
          children: _screen,
        ),
        bottomNavigationBar: Consumer<BottomNavbarController>(
          builder: (_,bottomNavbarController,__) {
            return GNav(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              backgroundColor: Colors.white,
              selectedIndex: bottomNavbarController.navBarIndex,
              onTabChange: (value){
                bottomNavbarController.setNavBarIndex = value;
              },
              hoverColor: AppColors.grey,
              textSize: 20,
              iconSize: 28,
              haptic: false,
              style: GnavStyle.google,
              activeColor: AppColors.themeColor,
              tabBackgroundColor: AppColors.secondaryThemeColor,
              tabBorderRadius: 30,
              tabMargin: const EdgeInsets.all(10),
              color: Colors.white,
              tabs:   [
                const GButton(
                  iconColor: AppColors.black,
                  icon: EvaIcons.homeOutline,
                  text: " হোম",
                ),
                const GButton(
                  iconColor: AppColors.black,
                  icon: Icons.airplane_ticket_outlined,
                  text: " বিমানের টিকিট",
                ),
                GButton(
                  iconColor: AppColors.black,
                  icon: EvaIcons.shoppingCartOutline,
                  text: " শপিং কার্ট",
                  leading: (context.read<CartController>().cartList.isNotEmpty) ? Badge(
                    backgroundColor: AppColors.themeColor,
                    label: Text(context.read<CartController>().cartList.length.toString()),
                    child: const Icon(EvaIcons.shoppingCartOutline),
                  ) : null,
                ),
                const GButton(
                  iconColor: AppColors.black,
                  icon: Icons.shopping_bag_outlined,
                  text: " অর্ডার লিস্ট",
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
