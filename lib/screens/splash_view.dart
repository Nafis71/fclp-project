import 'dart:convert';

import 'package:fclp_app/Controllers/notification_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/models/user_model/user.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/screens/auth_view/login_view.dart';
import 'package:fclp_app/screens/non_authorized_screen/non_authorized_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../services/prefetch_service.dart';
import 'main_bottom_nav_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingScaleUp(
                    duration: const Duration(seconds: 3)),
                child: Image.asset(AssetsPaths.appLogo),
              ),
            ),
            CircularProgressIndicator(
              color: Colors.black,
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  void checkToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    if (token != null) {
      User userData = User.fromJson(
          jsonDecode(preferences.getString("userData").toString()));
      if (mounted) {
        context.read<ProfileController>().setToken(token);
        loadUserData(userData);
        await loadInitialData();
        WidgetBuilder? widgetBuilder;
        if (mounted) {
          if (context.read<ProfileController>().userData.status == "0" ||
              context.read<ProfileController>().userData.status == "2") {
            widgetBuilder = (context) => const NonAuthorizedScreen();
          } else {
            await context
                .read<NotificationController>()
                .getAllNotification(token);
            await context.read<ProfileController>().getSocialLink();
            widgetBuilder = (context) => const MainBottomNavView();
          }
          if (mounted) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: widgetBuilder));
          }
        }
      }
      return;
    }
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginView()));
    }
  }

  void loadUserData(User userData) {
    context.read<ProfileController>().userData = userData;
  }

  Future<void> loadInitialData() async {
    try {
      await Future.wait([
        PrefetchService.loadCartData(context),
        PrefetchService.loadProductData(1, context),
        PrefetchService.loadOrderList(context),
      ]);
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
    }
  }
}
