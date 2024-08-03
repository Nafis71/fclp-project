import 'package:fclp_app/utils/assets_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AirTicketBanner extends StatelessWidget {
  const AirTicketBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      width: double.maxFinite,
      child: SvgPicture.asset(
        AssetsPaths.airTicketBanner,
        fit: BoxFit.fill,
      ),
    );
  }
}
