import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/assets_paths.dart';
import '../../utils/color_palette.dart';

class DeliveryLocationContainer extends StatelessWidget {
  final String location, deliveryAmount;
  final Color borderColor;
  final double borderWidth;
  final bool hasPressed;

  const DeliveryLocationContainer(
      {super.key,
      required this.location,
      required this.deliveryAmount,
      required this.borderColor,
      required this.borderWidth,
      required this.hasPressed});

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetsPaths.deliveryTruck,
                          width: 35,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                location,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontSize: 12,
                                        color: AppColors.themeColor),
                              ),
                              Text(
                                deliveryAmount,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
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
  }
}
