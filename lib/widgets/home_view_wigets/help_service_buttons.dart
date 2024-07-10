import 'package:fclp_app/Controllers/url_launcher_controller.dart';
import 'package:fclp_app/widgets/home_view_wigets/service_buttons.dart';
import 'package:flutter/material.dart';

class HelpServiceButtons extends StatelessWidget {
  const HelpServiceButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ServiceButtons(
            imagePath: 'assets/facebook.png',
            label: 'গ্রুপে যুক্ত হন',
            onTabService: UrlLauncherController.facebookLauncheUrl,
          ),
          ServiceButtons(
            imagePath: 'assets/youtube.png',
            label: 'ভিডিও দেখুন',
            onTabService: UrlLauncherController.youTubeLauncheUrl,
          ),
          ServiceButtons(
            imagePath: 'assets/telegram.png',
            label: 'টেলিগ্রাম',
            onTabService: UrlLauncherController.telegramLauncheUrl,
          ),
          ServiceButtons(
            imagePath: 'assets/tiktok.png',
            label: 'টিকটক',
            onTabService: UrlLauncherController.tiktokLaunchUrl,
          ),
        ],
      ),
    );
  }
}
