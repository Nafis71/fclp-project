import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.035,
                ),
                child: SvgPicture.asset(
                  imagePath,
                  width: 32,
                  fit: BoxFit.cover,
                )),
          ),
          const SizedBox(height: 5.0),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
