import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/assets_pahts.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Wrap(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "স্বাগতম",
                    style: TextStyle(
                      fontSize: 30,
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Wrap(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      context.read<ProfileController>().name,
                      style:  TextStyle(
                        fontSize: 16,
                        color: AppColors.themeColor,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
          Lottie.asset(AssetsPahts.welcomeLottie,
              fit: BoxFit.contain, backgroundLoading: true, width: 180, renderCache: RenderCache.drawingCommands,repeat: true),
        ],
      ),
    );
  }
}
