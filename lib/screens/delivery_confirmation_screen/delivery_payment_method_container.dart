import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/color_palette.dart';

class DeliveryPaymentMethodContainer extends StatelessWidget {
  final Color borderColor;
  final double borderWidth;
  final bool hasPressed;
  final String assetName;

  const DeliveryPaymentMethodContainer(
      {super.key,
      required this.borderColor,
      required this.borderWidth,
      required this.hasPressed,
      required this.assetName});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.fromBorderSide(
                  BorderSide(color: borderColor, width: borderWidth)),
            ),
            child: SvgPicture.asset(
              assetName,
              width: 120,
            ),
          ),
        ),
        if (hasPressed)
          Positioned(
            top: -2,
            child: Icon(
              Icons.verified_rounded,
              color: AppColors.themeColor,
            ),
          ),
      ],
    );
    ;
  }
}
