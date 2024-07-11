import 'package:device_preview/device_preview.dart';
import 'package:fclp_app/themes/app_theme.dart';
import 'package:fclp_app/utils/size_config.dart';
import 'package:fclp_app/views/auth_view/login_view.dart';
import 'package:fclp_app/views/splash_view.dart';
import 'package:flutter/material.dart';

class FCLP extends StatelessWidget {
  const FCLP({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const SplashView(),
      theme: lightThemeData(),
      darkTheme: darkThemeData(),
      themeMode: ThemeMode.system,
    );
  }
}
