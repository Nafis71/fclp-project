import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

Widget infoSection({
  String? titleHint,
  String? title,
}) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$titleHint: $title",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: AppColors.themeColor,
            ),
          ),
        ],
      ),
    ),
  );
}
