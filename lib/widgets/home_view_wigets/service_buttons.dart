import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class ServiceButtons extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback? onTabService;

  const ServiceButtons({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTabService,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTabService,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: AppColors.themeColor,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Image.asset(
                imagePath,
                height: 40.0,
                width: 40.0,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12.0,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
