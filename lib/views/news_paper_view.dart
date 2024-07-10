import 'package:fclp_app/utils/assets_pahts.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NewsPaperView extends StatefulWidget {
  const NewsPaperView({super.key});

  @override
  State<NewsPaperView> createState() => _NewsPaperViewState();
}

class _NewsPaperViewState extends State<NewsPaperView> {
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
