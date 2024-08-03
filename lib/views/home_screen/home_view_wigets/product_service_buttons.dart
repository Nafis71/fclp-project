import 'package:fclp_app/Controllers/air_ticket_controller.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/air_ticket_booking_view/air_ticket_view.dart';
import 'package:fclp_app/views/blood_bank_view.dart';
import 'package:fclp_app/views/home_screen/home_view_wigets/service_buttons.dart';
import 'package:fclp_app/views/news_paper_view.dart';
import 'package:fclp_app/views/online_doctor_view.dart';
import 'package:fclp_app/views/online_shop_category_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductServiceButtons extends StatelessWidget {
  const ProductServiceButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      color: AppColors.backgroundColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ServiceButtons(
              imagePath: AssetsPaths.airTicketIcon,
              label: 'এয়ার টিকেট',
              onTabService: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AirTicketView(),
                  ),
                ).then((value) {
                  context.read<AirTicketController>().resetData();
                });
              },
            ),
            ServiceButtons(
              imagePath: AssetsPaths.newsPaperIcon,
              label: 'নিউজ পেপার',
              onTabService: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewsPaperView(),
                  ),
                );
              },
            ),
            ServiceButtons(
              imagePath: AssetsPaths.onlineShopIcon,
              label: 'অনলাইন শপ',
              onTabService: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnlineShopCategoryView(),
                  ),
                );
              },
            ),
            ServiceButtons(
              imagePath: AssetsPaths.bloodBankIcon,
              label: 'ব্লাড ব্যাংক',
              onTabService: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BloodBannkView(),
                  ),
                );
              },
            ),
            ServiceButtons(
              imagePath: AssetsPaths.onlineDoctorIcon,
              label: 'অনলাইন ডাক্তার',
              onTabService: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OnlineDoctorView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
