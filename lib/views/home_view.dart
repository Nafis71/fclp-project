import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/custom_drawer.dart';
import 'package:fclp_app/widgets/global_widgets/product_grid_view.dart';
import 'package:fclp_app/widgets/home_view_wigets/air_ticket_banner.dart';
import 'package:fclp_app/widgets/home_view_wigets/help_service_buttons.dart';
import 'package:fclp_app/widgets/home_view_wigets/product_service_buttons.dart';
import 'package:fclp_app/widgets/home_view_wigets/welcome_banner.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const CustomDrawer(
        fromHomeView: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const WelcomeBanner(),
            const HelpServiceButtons(),
            const AirTicketBanner(),
            const ProductSeviceButtons(),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 40,
                width: 200,
                decoration: const BoxDecoration(
                    color: AppColors.themeColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
                child: const Center(
                  child: FittedBox(
                    child: Text(
                      "আপনার প্রয়োজনীয় পণ্য",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const ProductGridView(),
          ],
        ),
      ),
    );
  }
}
