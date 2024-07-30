import 'package:easy_stepper/easy_stepper.dart';
import 'package:fclp_app/Controllers/order_controller.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/utils/constants.dart';
import 'package:fclp_app/views/delivery_confirmation_screen/delivery_detail_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DeliveryConfirmationView extends StatefulWidget {
  final int orderId;
  const DeliveryConfirmationView({super.key, required this.orderId});

  @override
  State<DeliveryConfirmationView> createState() => _DeliveryConfirmationViewState();
}

class _DeliveryConfirmationViewState extends State<DeliveryConfirmationView> {
  List<Widget> pages = [
    const DeliveryDetailForm(),
  ];
  int activeStep = 0;
  @override
  void initState() {
    context.read<OrderController>().setCurrentSelectedOrderId = widget.orderId;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60,),
            EasyStepper(
              activeStep: activeStep,
              stepShape: StepShape.circle,
              stepBorderRadius: 15,
              borderThickness: 4,
              padding: const EdgeInsets.all(20),
              stepRadius: 28,
              finishedStepBackgroundColor: Colors.white,
              finishedStepTextColor: Colors.grey,
              showLoadingAnimation: false,
              activeStepTextColor: AppColors.themeColor,
              activeStepBorderColor: AppColors.themeColor,
              activeStepBorderType: BorderType.normal,
              unreachedStepBorderColor: AppColors.transparent,
              enableStepTapping: false,
              stepAnimationDuration: const Duration(seconds: 1),
              lineStyle: const LineStyle(
                lineType: LineType.dashed
              ),
              steps: [
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset(AssetsPaths.boxIcon),
                  ),
                  title: 'ডেলিভারী তথ্য',
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.monetization_on_rounded,color: AppColors.themeColor,size: 35,),
                  ),
                  title: 'পেমেন্ট',
                  enabled: true
                ),
                EasyStep(
                    customStep: CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.verified,size: 35,color: AppColors.themeColor,),
                    ),
                    title: 'সমাপ্ত',
                    enabled: true
                ),
              ],
              onStepReached: (index) =>
                  setState(() => activeStep = index),
            ),
            // IndexedStack(
            //   children: [
            //     DeliveryDetailForm(),
            //   ],
            //   index: activeStep,
            // )
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: PageView.builder(itemCount: pages.length,itemBuilder: (context,index){
                return pages[activeStep];
              }),
            )
          ],
        ),
      ),
    );
  }
}
