import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/Controllers/auth_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/Controllers/url_launcher_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/utils/style.dart';
import 'package:fclp_app/views/auth_view/login_view.dart';
import 'package:fclp_app/views/business_view.dart';
import 'package:fclp_app/views/income_points_view.dart';
import 'package:fclp_app/views/main_bottom_nav_view.dart';
import 'package:fclp_app/views/profile_view.dart';
import 'package:fclp_app/views/refer_id_screen/reffer_id_view.dart';
import 'package:fclp_app/views/system_view.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:fclp_app/widgets/profile_widgets/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    this.fromHomeView = false,
    this.fromIncomePointView = false,
    this.fromProfileView = false,
    this.fromSystemView = false,
    this.fromBusinessView = false,
    this.fromRefferIdView = false,
  });

  final bool fromHomeView;
  final bool fromIncomePointView;
  final bool fromProfileView;
  final bool fromSystemView;
  final bool fromBusinessView;
  final bool fromRefferIdView;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final GlobalKey alertDialogKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = context.read<ProfileController>();
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.green,
                  ),
                ),
              ),
              child: Container(
                color: AppColors.themeColor,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                getImage(context.read<ProfileController>()),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            context
                                .read<ProfileController>()
                                .userData
                                .name
                                .toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 130,
                      left: 0,
                      right: 0,
                      bottom: -70,
                      child: Container(
                        margin: const EdgeInsets.all(50),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            ),
                            foregroundColor: AppColors.themeColor,
                            elevation: 4
                          ),
                          onPressed: () {},
                          child: (profileController.userData.status == "1")
                              ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.verified,color: AppColors.themeColor,),
                                  const Text("Account is activated",style: TextStyle(
                                    fontSize: 14
                                  ),),
                                ],
                              )
                              : const Text("Account isn't activated"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                if (profileController.userData.status == "0" ||
                    profileController.userData.status == "2") {
                  warningDialog(
                      context: context,
                      warningDescription: AppStrings.paymentAskingMessage);
                  Scaffold.of(context).closeDrawer();
                  return;
                }
                _onTapHomeButton(
                  fromHomeView: widget.fromHomeView,
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.home_outlined,
                      size: 31,
                      color: AppColors.themeColor,
                    )),
                title: const Text("হোম"),
              ),
            ),
            InkWell(
              onTap: () {
                if (profileController.userData.status == "0" ||
                    profileController.userData.status == "2") {
                  warningDialog(
                      context: context,
                      warningDescription: AppStrings.paymentAskingMessage);
                  Scaffold.of(context).closeDrawer();
                  return;
                }
                _onTapProfileButton(
                  fromProfileView: widget.fromProfileView,
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.perm_identity,
                    size: 30,
                    color: AppColors.themeColor,
                  ),
                ),
                title: const Text("আমার প্রোফাইল"),
              ),
            ),
            InkWell(
              onTap: () {
                if (profileController.userData.status == "0" ||
                    profileController.userData.status == "2") {
                  warningDialog(
                      context: context,
                      warningDescription: AppStrings.paymentAskingMessage);
                  Scaffold.of(context).closeDrawer();
                  return;
                }
                _onTapIncomePointButton(
                    fromIncomePiointView: widget.fromIncomePointView);
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.currency_exchange,
                    color: AppColors.themeColor,
                  ),
                ),
                title: const Text("ইনকাম পয়েন্ট"),
              ),
            ),
            InkWell(
              onTap: () {
                if (profileController.userData.status == "0" ||
                    profileController.userData.status == "2") {
                  warningDialog(
                      context: context,
                      warningDescription: AppStrings.paymentAskingMessage);
                  Scaffold.of(context).closeDrawer();
                  return;
                }
                UrlLauncherController.makePhoneCall;
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.phone_outlined,
                    size: 30,
                    color: AppColors.themeColor,
                  ),
                ),
                title: const Text("যোগাযোগ"),
              ),
            ),
            InkWell(
              onTap: () {
                if (profileController.userData.status == "0" ||
                    profileController.userData.status == "2") {
                  warningDialog(
                      context: context,
                      warningDescription: AppStrings.paymentAskingMessage);
                  Scaffold.of(context).closeDrawer();
                  return;
                }
                _onTapBusinessButton(
                  fromBusinessView: widget.fromBusinessView,
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.cases_outlined,
                    color: AppColors.themeColor,
                  ),
                ),
                title: const Text("বিজনেস"),
              ),
            ),
            InkWell(
              onTap: () {
                if (profileController.userData.status == "0" ||
                    profileController.userData.status == "2") {
                  warningDialog(
                      context: context,
                      warningDescription: AppStrings.paymentAskingMessage);
                  Scaffold.of(context).closeDrawer();
                  return;
                }
                _onTapRefferIDButton(
                  fromRefferIdView: widget.fromRefferIdView,
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.discount_outlined,
                      color: AppColors.themeColor,
                    )),
                title: const Text("রেফার আইডি"),
              ),
            ),
            InkWell(
              onTap: () {
                if (profileController.userData.status == "0" ||
                    profileController.userData.status == "2") {
                  warningDialog(
                      context: context,
                      warningDescription: AppStrings.paymentAskingMessage);
                  Scaffold.of(context).closeDrawer();
                  return;
                }
                _onTapSystemButton(
                  fromSystemView: widget.fromSystemView,
                );
              },
              child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.settings,
                      color: AppColors.themeColor,
                    )),
                title: const Text("সিস্টেম"),
              ),
            ),
            InkWell(
              onTap: () {
                _onTapLogOutButton();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginView(),
                  ),
                );
              },
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                ),
                title: Text("লগ আউট"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapIncomePointButton({
    required bool fromIncomePiointView,
  }) {
    if (fromIncomePiointView) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const IncomePointsView(),
      ),
    );
  }

  void _onTapHomeButton({
    required bool fromHomeView,
  }) {
    if (fromHomeView) {
      return;
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const MainBottomNavView(),
        ),
        (route) => false);
  }

  void _onTapProfileButton({
    required bool fromProfileView,
  }) {
    if (fromProfileView) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileView(),
      ),
    ).then((value) {
      context.read<ProfileController>().setResetBase64Image();
    });
  }

  void _onTapSystemButton({
    required bool fromSystemView,
  }) {
    if (fromSystemView) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SystemView(),
      ),
    );
  }

  void _onTapRefferIDButton({
    required bool fromRefferIdView,
  }) {
    if (fromRefferIdView) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RefferIdView(),
      ),
    );
  }

  void _onTapBusinessButton({
    required bool fromBusinessView,
  }) {
    if (fromBusinessView) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BusinessView(),
      ),
    );
  }

  Future<void> _onTapLogOutButton() async {
    await context
        .read<AuthController>()
        .logoutUser(context.read<ProfileController>().token);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
