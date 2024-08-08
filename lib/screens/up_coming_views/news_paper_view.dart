import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

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
        appBar: customAppBar(context),
        body: Center(
          child: Text("শীঘ্রই আসছে",style: Theme.of(context).textTheme.titleLarge,),
        ),
      ),
    );
  }
}
