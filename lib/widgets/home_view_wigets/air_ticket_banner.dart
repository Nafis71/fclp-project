import 'package:fclp_app/utils/assets_pahts.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

class AirTicketBanner extends StatelessWidget {
  const AirTicketBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: AppColors.white,
        image: DecorationImage(
          image: AssetImage(AssetsPahts.airTicket),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
