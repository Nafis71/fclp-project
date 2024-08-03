import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

Widget infoSection({
  String? titleHint,
  String? title,
}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: AppColors.secondaryThemeColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$titleHint: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.themeColor,
            ),
          ),
          Text(
            "$title",
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    ),
  );
}
