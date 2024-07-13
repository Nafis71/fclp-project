import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

void warningDialog({
  required BuildContext context,
  required String warningDescription,
  String? message
}) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: 250,
            width: 350,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        child: Text(
                          (message ==null) ? "Warning" : message,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        warningDescription,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("CLOSE"),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: -40,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: AppColors.themeColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.warning,
                      color: AppColors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
