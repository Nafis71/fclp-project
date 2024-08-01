import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/income_points_screen/income_points_view.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ReferredIdView extends StatefulWidget {
  const ReferredIdView({super.key});

  @override
  State<ReferredIdView> createState() => _ReferredIdViewState();
}

class _ReferredIdViewState extends State<ReferredIdView> {
  @override
  void initState() {
    loadReferrals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                right: 10,
                child: IconButton(
                  onPressed: () {
                    openReferralInformation();
                  },
                  icon:  Icon(
                    Icons.info_outline_rounded,
                    size: 32,
                    color: AppColors.themeColor,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AssetsPaths.referImage,
                    width: 240,
                  ),
                  Text(
                    "আপনার রেফার আইডি",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryThemeColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Ref ID: ${context.read<ProfileController>().userData.referralCode.toString()}",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const IncomePointsView(),
                          ),
                        );
                      },
                      child: const Text("পয়েন্ট চেক করুন"),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.yourReferText,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Consumer<ProfileController>(
                          builder: (_, profileController, __) {
                            return Text(
                              "${AppStrings.totalReferText}: ${profileController.referralList.length}",
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                          }),
                    ],
                  ),
                  const SizedBox(height: 0),
                  Consumer<ProfileController>(
                      builder: (_, profileController, __) {
                        if (profileController.isLoadingReferral) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.themeColor,
                            ),
                          );
                        }
                        if (profileController.referralList.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Center(
                              child: Text("আপনি এখনও কাউকে রেফার করেননি।"),
                            ),
                          );
                        }
                        return ListView.separated(
                          reverse: true,
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: profileController.referralList.length,
                          itemBuilder: (_, index) => ListTile(
                            tileColor: Colors.grey.shade100,
                            contentPadding: const EdgeInsets.all(8),
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundColor: AppColors.secondaryThemeColor,
                              child: Text(
                                profileController.referralList[index].name!
                                    .substring(0, 1),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.themeColor),
                              ),
                            ),
                            title: Text(
                              profileController.referralList[index].name!,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 5,
                            );
                          },
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openReferralInformation() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            AppStrings.referralInfoHeaderText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(
            AppStrings.referralInformation,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.normal),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  overlayColor: AppColors.secondaryThemeColor),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Close",
                style: TextStyle(color: AppColors.themeColor),
              ),
            ),
          ],
        ));
  }

  Future<void> loadReferrals() async {
    await context.read<ProfileController>().loadReferrals();
  }
}
