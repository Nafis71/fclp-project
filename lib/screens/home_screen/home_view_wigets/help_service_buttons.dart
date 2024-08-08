import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/Controllers/url_launcher_controller.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/screens/home_screen/home_view_wigets/service_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelpServiceButtons extends StatelessWidget {
  const HelpServiceButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ServiceButtons(
            imagePath: AssetsPaths.facebookIcon,
            label: 'গ্রুপে যুক্ত হন',
            onTabService: () {
              UrlLauncherController.facebookLauncheUrl(
                  context.read<ProfileController>().facebookLink.toString());
            },
          ),
          ServiceButtons(
            imagePath: AssetsPaths.youtubeIcon,
            label: 'ভিডিও দেখুন',
            onTabService: () {
              UrlLauncherController.youTubeLauncheUrl(
                  context.read<ProfileController>().youtubeLink.toString());
            },
          ),
          ServiceButtons(
            imagePath: AssetsPaths.telegramIcon,
            label: 'টেলিগ্রাম',
            onTabService: () {
              UrlLauncherController.telegramLauncheUrl(
                  context.read<ProfileController>().telegramLink.toString());
            },
          ),
          ServiceButtons(
            imagePath: AssetsPaths.tiktokIcon,
            label: 'টিকটক',
            onTabService: () {
              UrlLauncherController.tiktokLaunchUrl(
                  context.read<ProfileController>().tiktokLink.toString());
            },
          ),
        ],
      ),
    );
  }
}
