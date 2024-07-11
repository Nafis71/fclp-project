import 'package:fclp_app/utils/assets_pahts.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AirTicketBanner extends StatelessWidget {
  const AirTicketBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      width: double.maxFinite,
      child: SvgPicture.asset(AssetsPahts.airTicket,fit: BoxFit.fill,),
    );
  }
}
