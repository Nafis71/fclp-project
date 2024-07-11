import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/Controllers/url_launcher_controller.dart';
import 'package:fclp_app/utils/assets_pahts.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/utils/style.dart';
import 'package:fclp_app/views/auth_view/login_view.dart';
import 'package:fclp_app/views/business_view.dart';
import 'package:fclp_app/views/income_points_view.dart';
import 'package:fclp_app/views/main_bottom_nav_view.dart';
import 'package:fclp_app/views/profile_view.dart';
import 'package:fclp_app/views/reffer_id_view.dart';
import 'package:fclp_app/views/system_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  color: Colors.grey,
                ),
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(AssetsPahts.profile),
                          ),
                        ),
                      ),
                      const Text(
                        "এফ সি এল পি",
                        style: TextStyle(
                          color: AppColors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        context.read<ProfileController>().mobileNumber,
                        style: const TextStyle(
                          color: AppColors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                       Text(
                        context.read<ProfileController>().name,
                        style: const TextStyle(
                          color: AppColors.green,
                          fontSize: 17,
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
                      style: drawerButtonStyle,
                      onPressed: () {},
                      child: const Text("Account Complete 8%"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () => _onTapHomeButton(
              fromHomeView: widget.fromHomeView,
            ),
            child: const Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: FaIcon(
                    FontAwesomeIcons.house,
                    color: AppColors.themeColor,
                  ),
                ),
                title: Text("হোম"),
              ),
            ),
          ),
          InkWell(
            onTap: () => _onTapProfileButton(
              fromProfileView: widget.fromProfileView,
            ),
            child: const Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: FaIcon(
                    FontAwesomeIcons.user,
                    color: AppColors.themeColor,
                  ),
                ),
                title: Text("আমার প্রোফাইল"),
              ),
            ),
          ),
          InkWell(
            onTap: () => _onTapIncomePointButton(
                fromIncomePiointView: widget.fromIncomePointView),
            child: const Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: FaIcon(
                    FontAwesomeIcons.moneyBill1Wave,
                    color: AppColors.themeColor,
                  ),
                ),
                title: Text("ইনকাম পয়েন্ট"),
              ),
            ),
          ),
          const InkWell(
            onTap: UrlLauncherController.makePhoneCall,
            child: Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: FaIcon(
                    FontAwesomeIcons.phone,
                    color: AppColors.themeColor,
                  ),
                ),
                title: Text("যোগাযোগ"),
              ),
            ),
          ),
          InkWell(
            onTap: () => _onTapBusinessButton(
              fromBusinessView: widget.fromBusinessView,
            ),
            child: const Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: FaIcon(
                    FontAwesomeIcons.businessTime,
                    color: AppColors.themeColor,
                  ),
                ),
                title: Text("বিজনেস"),
              ),
            ),
          ),
          InkWell(
            onTap: () => _onTapRefferIDButton(
              fromRefferIdView: widget.fromRefferIdView,
            ),
            child: const Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: FaIcon(
                    FontAwesomeIcons.userTag,
                    color: AppColors.themeColor,
                  ),
                ),
                title: Text("রেফার আইডি"),
              ),
            ),
          ),
          InkWell(
            onTap: () => _onTapSystemButton(
              fromSystemView: widget.fromSystemView,
            ),
            child: const Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: FaIcon(
                    FontAwesomeIcons.mobileScreen,
                    color: AppColors.themeColor,
                  ),
                ),
                title: Text("সিস্টেম"),
              ),
            ),
          ),
          InkWell(
            onTap: _onTapLogOutButton,
            child: const Card(
              child: ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                ),
                title: Text("লগ আউট"),
              ),
            ),
          ),
        ],
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
          builder: (context) => MainBottomNavView(),
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
    );
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

  void _onTapLogOutButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginView(),
      ),
    );
  }
}
