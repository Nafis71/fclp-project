import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class PointView extends StatelessWidget {
  const PointView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColors.themeColor,
      color: Colors.white,
      onRefresh: ()async{},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset(
                      AssetsPaths.bagOfCoin,
                      width: 250,
                    ),
                    Text(
                      AppStrings.incomePointHeaderText,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      context.read<ProfileController>().userData.points,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: Colors.black),
                    ),
                    const SizedBox(height: 20,),
                    Consumer<ProfileController>(
                      builder: (_,profileController,__) {
                        int points = int.parse(profileController.userData.points);
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: points > 10 ? AppColors.themeColor : Colors.grey,
                              elevation: 5
                            ),
                            onPressed: () {
                              if(points <= 10){
                                return;
                              }
                            },
                            child: const Text("উত্তোলন করুন"),
                          ),
                        );
                      }
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryThemeColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Note :",
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  AppStrings.incomePointNoticeText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 13.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
