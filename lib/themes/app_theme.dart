import 'package:fclp_app/themes/app_text_theme.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightThemeData() {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: AppTextTheme.getLightTextTheme(),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: AppColors.themeColor,
      prefixIconColor: AppColors.grey,
      hintStyle: const TextStyle(
        color: AppColors.grey,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      errorMaxLines: 4,
      border: InputBorder.none,
      fillColor: Colors.white,
      filled: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        fixedSize: const Size.fromWidth(double.maxFinite),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(50),
        backgroundColor: AppColors.transparent,
        foregroundColor: AppColors.red,
        overlayColor: AppColors.white,
        fixedSize: const Size.fromWidth(double.maxFinite),
        textStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        side: BorderSide(
          color: AppColors.themeColor,
          width: 2,
          style: BorderStyle.solid,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.themeColor
      ),
      surfaceTintColor: Colors.white,
      iconTheme: IconThemeData(
        size: 30,
        color: AppColors.themeColor,
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: "Poppins Bold",
        color: AppColors.themeColor,
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: AppColors.red,
      unselectedItemColor: AppColors.white,
      backgroundColor: AppColors.green,
      elevation: 16,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedIconTheme: IconThemeData(
        color: AppColors.red,
        size: 30,
      ),
      unselectedIconTheme: IconThemeData(
        color: AppColors.white,
        size: 25,
      ),
      selectedLabelStyle: TextStyle(
          color: AppColors.red, fontWeight: FontWeight.bold, fontSize: 16),
      unselectedLabelStyle: TextStyle(
          color: AppColors.green, fontWeight: FontWeight.bold, fontSize: 12),
    ),
  );
}
