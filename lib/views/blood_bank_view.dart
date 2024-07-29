import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BloodBannkView extends StatefulWidget {
  const BloodBannkView({super.key});

  @override
  State<BloodBannkView> createState() => _BloodBannkViewState();
}

class _BloodBannkViewState extends State<BloodBannkView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(),
        body: Center(
          child: Lottie.asset(AssetsPaths.commingSoon),
        ),
      ),
    );
  }
}
