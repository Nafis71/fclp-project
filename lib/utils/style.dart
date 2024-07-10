import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

ButtonStyle drawerButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: AppColors.green,
  foregroundColor: Colors.white,
  fixedSize: const Size.fromWidth(double.maxFinite),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50),
  ),
  textStyle: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  ),
);
