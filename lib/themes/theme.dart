import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

InputDecoration textFormInputDecoration({
  required String hintText,
}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.green,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.green,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.green,
        width: 2,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        color: AppColors.green,
        width: 2,
      ),
    ),
    fillColor: AppColors.white,
    filled: true,
    hintText: hintText,
  );
}

ButtonStyle buttonStyle({
  required Color buttonColor,
}) {
  return ElevatedButton.styleFrom(
    backgroundColor: buttonColor,
    foregroundColor: AppColors.white,
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
}
