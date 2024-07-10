import 'package:fclp_app/utils/assets_pahts.dart';
import 'package:fclp_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget buildEmptyWidget({
  required BuildContext context,
  required String message,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          AssetsPahts.empty,
          width: SizeConfig.screenWidth! / 1.5,
        ),
        Text(
          message,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
  );
}
