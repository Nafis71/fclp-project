import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/main_bottom_nav_view.dart';
import 'package:fclp_app/views/payment_screen/payment_screen.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/custom_drawer.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NonAuthorizedScreen extends StatelessWidget {
  const NonAuthorizedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AssetsPaths.payment,
                    fit: BoxFit.contain,
                    width: 400,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(children: [
                          TextSpan(
                              text: "FCLP",
                              style: TextStyle(
                                  color: AppColors.themeColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          const TextSpan(
                              text:
                                  " তে আপনাকে স্বাগতম, অ্যাপটি ব্যবহার করতে আপনাকে এককালীন 300 টাকা দিতে হবে।",
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 15))
                        ])),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: const Text(
                      textAlign: TextAlign.justify,
                      "আপনি শুধুমাত্র এই দুটি এসএসএল কমার্স দ্বারা অর্থ প্রদান করতে পারবেন।",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PaymentScreen(paymentMethod: "Bkash"),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          AssetsPaths.bkashSvg,
                          fit: BoxFit.contain,
                          width: 100,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PaymentScreen(paymentMethod: "Nagad"),
                            ),
                          );
                        },
                        child: SvgPicture.asset(
                          AssetsPaths.nagadSvg,
                          fit: BoxFit.contain,
                          width: 100,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .8,
                      child: Consumer<ProfileController>(
                          builder: (_, profileController, __) {
                        return Visibility(
                          visible: !profileController.isLoading,
                          replacement: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.themeColor,
                            ),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 4),
                            onPressed: () {
                              checkProfileActiveStatus(
                                  profileController, context);
                            },
                            child:
                                const Text("অ্যাকাউন্টের অবস্থা পরীক্ষা করুন"),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkProfileActiveStatus(
      ProfileController profileController, BuildContext context) async {
    bool status = await profileController.checkProfileActiveStatus();
    if (status && context.mounted) {
      snackBarMessage(
          context: context,
          message: AppStrings.accountActivationSuccessMessage);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const MainBottomNavView()),
          (route) => false);
      return;
    }
    if (profileController.userData.status == "2" && context.mounted) {
      warningDialog(
          context: context,
          warningDescription: AppStrings.accountActivationCanceledMessage,
          message: AppStrings.accountActivationCanceledTitle);
      return;
    }
    if (context.mounted) {
      warningDialog(
          context: context,
          warningDescription: AppStrings.accountActivationFailedMessage,
          message: AppStrings.accountActivationFailedTitle);
    }
  }
}
