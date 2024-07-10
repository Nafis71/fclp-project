import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

void airticketSubmissionMessage(
  BuildContext context,
) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Icon(
          Icons.check,
          size: 60,
          color: AppColors.green,
        ),
        content: const SizedBox(
          height: 100,
          child: FittedBox(
            child: Column(
              children: [
                Text(
                  "অভিনন্দন",
                  style: TextStyle(
                    color: AppColors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "আপনার আবেদনটি সফল হয়েছে।",
                  style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("ওকে"),
          ),
        ],
      );
    },
  );
}
