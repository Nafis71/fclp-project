import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RefferIdView extends StatefulWidget {
  const RefferIdView({super.key});

  @override
  State<RefferIdView> createState() => _RefferIdViewState();
}

class _RefferIdViewState extends State<RefferIdView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      drawer: const CustomDrawer(
        fromRefferIdView: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsPaths.referImage,
                width: 240,
              ),
              Text(
                "আপনার রেফার আইডি",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.secondaryThemeColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 25,
                            offset: const Offset(1, 5))
                      ]),
                  child: Text(
                    "Ref ID: ${context.read<ProfileController>().userData.referralCode.toString()}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Your Refers",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    "Total Referred: 20",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (_, index) => const ListTile(
                  title: Text("Nafis Hasan Tonmoy"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
