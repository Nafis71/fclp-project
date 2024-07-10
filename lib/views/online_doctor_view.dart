import 'package:fclp_app/utils/assets_pahts.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnlineDoctorView extends StatefulWidget {
  const OnlineDoctorView({super.key});

  @override
  State<OnlineDoctorView> createState() => _OnlineDoctorViewState();
}

class _OnlineDoctorViewState extends State<OnlineDoctorView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(),
        body: Center(
          child: Lottie.asset(AssetsPahts.commingSoon),
        ),
      ),
    );
  }
}
