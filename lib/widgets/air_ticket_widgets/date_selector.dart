import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

Widget dateSelector({
  required BuildContext context,
  required String date,
  required VoidCallback datePicked,
}) {
  return InkWell(
    onTap: datePicked,
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "ভ্রমন এর তারিখ",
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: AppColors.green,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.calendar_today,
            color: AppColors.green,
          ),
        ],
      ),
    ),
  );
}
