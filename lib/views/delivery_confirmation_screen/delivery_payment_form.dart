import 'package:fclp_app/Controllers/order_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/views/delivery_confirmation_screen/delivery_payment_method_container.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../Controllers/form_validation_controller.dart';
import '../../widgets/profile_widgets/form_input_decoration.dart';

class DeliveryPaymentForm extends StatefulWidget {
  const DeliveryPaymentForm({super.key});

  @override
  State<DeliveryPaymentForm> createState() => _DeliveryPaymentFormState();
}

class _DeliveryPaymentFormState extends State<DeliveryPaymentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _transTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                    duration: const Duration(seconds: 2),
                    delay: const Duration(milliseconds: 500)),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: AppColors.secondaryThemeColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(50)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 5))
                      ]),
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "01610658696",
                            style: TextStyle(
                                color: AppColors.themeColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        const TextSpan(
                            text: " নম্বরে টাকা পাঠান Send money অপশনে।",
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                      ]),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "পরিশোধের পদ্ধতি নির্বাচন করুন",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<OrderController>(builder: (_, orderController, __) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        orderController.setIsBkashSelected = true;
                        orderController.setIsBkashPressed = true;
                        orderController.setIsNagadPressed = false;
                      },
                      child: DeliveryPaymentMethodContainer(
                        borderColor: orderController.isBkashPressed
                            ? AppColors.themeColor
                            : AppColors.grey,
                        borderWidth: 1,
                        hasPressed: orderController.isBkashPressed,
                        assetName: AssetsPaths.bkashSvg,
                      ),
                    ),
                    InkWell(
                      splashColor: AppColors.transparent,
                      onTap: () {
                        orderController.setIsBkashSelected = false;
                        orderController.setIsBkashPressed = false;
                        orderController.setIsNagadPressed = true;
                      },
                      child: DeliveryPaymentMethodContainer(
                        borderColor: orderController.isNagadPressed
                            ? AppColors.themeColor
                            : AppColors.grey,
                        borderWidth: 1,
                        hasPressed: orderController.isNagadPressed,
                        assetName: AssetsPaths.nagadSvg,
                      ),
                    )
                  ],
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Consumer<OrderController>(builder: (_, orderController, __) {
                return TextFormField(
                    cursorColor: AppColors.themeColor,
                    controller: _mobileTEController,
                    keyboardType: TextInputType.number,
                    decoration: formInputDecoration(
                      hintText:
                          "আপনার ${orderController.isBkashSelected ? "বিকাশ" : "নগদ"} ফোন নম্বর",
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (orderController.isBkashSelected)
                        ? FormValidationController.validateBkashNumber
                        : FormValidationController.validateNagadNumber);
              }),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                cursorColor: AppColors.themeColor,
                controller: _transTEController,
                keyboardType: TextInputType.text,
                decoration: formInputDecoration(
                  hintText: "আপনার Transaction আইডি",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "বৈধ Transaction আইডি লিখুন";
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(
                height: 40,
              ),
              Consumer<OrderController>(
                builder: (_, orderController, __) {
                  if (orderController.isBusy) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.themeColor,
                      ),
                    );
                  }
                  return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          storePaymentInfo(orderController, context.read<ProfileController>().token);
                        }
                      },
                      child: const Text("পরিশোধ করুন"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> storePaymentInfo(
      OrderController orderController, String token) async {
    bool status = await orderController.storePaymentInfo(
        token, _transTEController.text, _mobileTEController.text);
    if (!status && mounted) {
      warningDialog(
          context: context,
          warningDescription: AppStrings.storePaymentInfoFailureMessage,
          message: AppStrings.storePaymentInfoFailureTitle);
    }
  }
}
