import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/assets_pahts.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/auth_view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

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
    loadToken();
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
                child: Image.asset(AssetsPahts.appLogo),
              ),
            ),
            const CircularProgressIndicator(color: AppColors.themeColor,),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }

  void loadToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    if(token != null){
      await Future.delayed(const Duration(seconds: 3));
      if(mounted){
        context.read<ProfileController>().setToken(token);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MainBottomNavView()));
      }
      return;
    }
    await Future.delayed(const Duration(seconds: 3));
    if(mounted){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginView()));
    }
  }
}
