import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/air_ticket_view.dart';
import 'package:fclp_app/views/blood_bank_view.dart';
import 'package:fclp_app/views/news_paper_view.dart';
import 'package:fclp_app/views/online_doctor_view.dart';
import 'package:fclp_app/views/online_shop_category_view.dart';
import 'package:fclp_app/widgets/home_view_wigets/service_buttons.dart';
import 'package:flutter/material.dart';

class ProductSeviceButtons extends StatelessWidget {
  const ProductSeviceButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      color: AppColors.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ServiceButtons(
            imagePath: 'assets/air_ticket.png',
            label: 'এয়ার টিকেট',
            onTabService: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AirTicketView(),
                ),
              );
            },
          ),
          ServiceButtons(
            imagePath: 'assets/newspapers.png',
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
            imagePath: 'assets/online_shop.png',
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
            imagePath: 'assets/blood_bank.png',
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
            imagePath: 'assets/online_doctor.png',
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
    );
  }
}
