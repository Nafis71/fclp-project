import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class SystemView extends StatefulWidget {
  const SystemView({super.key});

  @override
  State<SystemView> createState() => _SystemViewState();
}

class _SystemViewState extends State<SystemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const CustomDrawer(
        fromSystemView: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.themeColor,
                    width: 3,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      "নোটিশ",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      textAlign: TextAlign.justify,
                      "রেজিস্ট্রেশন মেম্বার এবং বিজনেস মেম্বার আপনাদের ইনকাম করার সুযোগ রয়েছে। আপনারা টাকা ইনকাম না করতে পারলেও রেজিস্ট্রেশন মেম্বার এবং বিজনেস মেম্বার সবাই ১ বছর পর আপনাদের একাঊন্টের টাকা সবাই পাবেন।",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "FCLP",
                      style: TextStyle(
                        color: AppColors.themeColor,
                        fontSize: 25,
                        fontFamily: "BlackOpsOne",
                      ),
                    ),
                    Text(
                      "Business Platform",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
