import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/home_view.dart';
import 'package:fclp_app/views/my_cart_view.dart';
import 'package:fclp_app/views/wishlist_view.dart';
import 'package:flutter/material.dart';
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
    const MyCartView(),
    const WishlistView()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screen[_selectedIndex],
        bottomNavigationBar: GNav(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          backgroundColor: Colors.white,
          selectedIndex: _selectedIndex,
          onTabChange: _onItemTapped,
          hoverColor: AppColors.grey,
          textSize: 20,
          iconSize: 28,
          haptic: false,
          activeColor: AppColors.white,
          tabBackgroundColor: Colors.green.shade400,
          tabBorderRadius: 15,
          tabMargin: const EdgeInsets.all(16),
          color: AppColors.green,
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: " হোম",
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
