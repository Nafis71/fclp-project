import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/air_ticket_booking_view/air_ticket_view.dart';
import 'package:fclp_app/views/home_view.dart';
import 'package:fclp_app/views/my_cart_view.dart';
import 'package:fclp_app/views/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainBottomNavView extends StatefulWidget {
  const MainBottomNavView({super.key});

  @override
  State<MainBottomNavView> createState() => _MainBottomNavViewState();
}

class _MainBottomNavViewState extends State<MainBottomNavView> {
  int _selectedIndex = 0;

  final List<Widget> _screen = [
    const HomeView(),
    const AirTicketView(),
    const MyCartView(),
    const WishlistView()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          statusBarColor: AppColors.themeColor,
          statusBarBrightness: Brightness.light
        ),
        child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _screen,
          ),
          bottomNavigationBar: GNav(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            backgroundColor: AppColors.themeColor,
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
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
            tabs: const [
              GButton(
                icon: Icons.home_outlined,
                text: " হোম",
              ),
              GButton(
                icon: Icons.airplane_ticket_outlined,
                text: " বিমানের টিকিট",
              ),
              GButton(
                icon: Icons.add_shopping_cart_rounded,
                text: " শপিং কার্ট",
              ),
              GButton(
                icon: Icons.favorite_border,
                text: " উইস লিস্ট",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (mounted) {
      setState(
        () {
          _selectedIndex = index;
        },
      );
    }
  }
}
