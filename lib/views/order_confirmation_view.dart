import 'package:fclp_app/utils/assets_pahts.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/utils/size_config.dart';
import 'package:fclp_app/views/main_bottom_nav_view.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderConfirmationView extends StatefulWidget {
  const OrderConfirmationView({super.key});

  @override
  State<OrderConfirmationView> createState() => _OrderConfirmationViewState();
}

class _OrderConfirmationViewState extends State<OrderConfirmationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(AssetsPahts.delivery),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    const Text(
                      "অর্ডার কনফার্মড",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "BlackOpsOne",
                        color: AppColors.themeColor,
                      ),
                    ),
                    const Text(
                      textAlign: TextAlign.center,
                      "আমরা অবিলম্বে আপনার অর্ডার পৌঁছে দেব,আপনার অর্ডার দোরগোড়ায় রাখা নিশ্চিত করুন।",
                      style: TextStyle(
                        color: AppColors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainBottomNavView(),
                            ),
                            (route) => false);
                      },
                      child: Container(
                        height: 60,
                        alignment: Alignment.center,
                        width: SizeConfig.screenWidth! / 1.8,
                        decoration: BoxDecoration(
                          color: AppColors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Check Order Status",
                          style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
