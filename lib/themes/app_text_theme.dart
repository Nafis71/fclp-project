import 'package:flutter/material.dart';

import '../utils/color_palette.dart';

class AppTextTheme {
  static TextTheme getLightTextTheme() => TextTheme(
        bodySmall: getDefaultTextStyle().copyWith(fontSize: 12),
        bodyMedium: getDefaultTextStyle().copyWith(fontSize: 12),
        titleLarge: getDefaultTextStyle().copyWith(
            fontSize: 22,
            color: AppColors.themeColor,
            fontWeight: FontWeight.bold,
            fontFamily: "Poppins Bold"),
        titleMedium: getDefaultTextStyle()
            .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
      );

  static TextStyle getDefaultTextStyle() => const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 13,
      fontFamily: "Poppins Regular");
}
