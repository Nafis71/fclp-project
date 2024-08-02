import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../Controllers/form_validation_controller.dart';
import '../../widgets/profile_widgets/form_input_decoration.dart';

class PaymentScreen extends StatefulWidget {
  final String paymentMethod;

  const PaymentScreen({super.key, required this.paymentMethod});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final TextEditingController _mobileTEController;
  late final TextEditingController _transTEController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _mobileTEController = TextEditingController();
    _transTEController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              WidgetAnimator(
                incomingEffect: WidgetTransitionEffects.incomingSlideInFromLeft(
                    duration: const Duration(seconds: 2),
                    delay: const Duration(milliseconds: 500)),
                atRestEffect: WidgetRestingEffects.wave(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
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
                        TextSpan(
                            text:
                                " নম্বরে টাকা পাঠান ${widget.paymentMethod} Send money অপশনে। অ্যাকাউন্ট অ্যাক্টিভেশন প্রায় 1/2 ঘন্টা সময় নিতে পারে",
                            style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                      ]),
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    (widget.paymentMethod.toLowerCase() == "bkash")
                        ? SvgPicture.asset(
                            AssetsPaths.bkashSvg,
                            width: 170,
                            fit: BoxFit.contain,
                          )
                        : SvgPicture.asset(
                            AssetsPaths.nagadSvg,
                            width: 170,
                            fit: BoxFit.contain,
                          ),
                    const SizedBox(
                      height: 40,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              cursorColor: AppColors.themeColor,
                              controller: _mobileTEController,
                              keyboardType: TextInputType.number,
                              decoration: formInputDecoration(
                                hintText:
                                    "আপনার ${widget.paymentMethod} ফোন নম্বর",
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (widget.paymentMethod.toLowerCase() ==
                                      "bkash")
                                  ? FormValidationController.validateBkashNumber
                                  : FormValidationController
                                      .validateNagadNumber),
                          const SizedBox(
                            height: 15,
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Consumer<ProfileController>(
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
                                  if (_formKey.currentState!.validate()) {
                                    accountActiveRequest();
                                  }
                                },
                                child: const Text(
                                    "অ্যাকাউন্ট সক্রিয় অনুরোধ করুন"),
                              ),
                            );
                          })
                        ],
                      ),
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

  Future<void> accountActiveRequest() async {
    bool status = await context.read<ProfileController>().activateProfile(
        _mobileTEController.text.trim(),
        _transTEController.text.trim(),
        widget.paymentMethod.toLowerCase());
    if (status && mounted) {
      snackBarMessage(
          context: context,
          message: AppStrings.accountActivationRequestSuccessMessage);
      Navigator.pop(context);
      return;
    }
    if (mounted) {
      warningDialog(
          context: context,
          warningDescription: AppStrings.accountActivationRequestFailedMessage,
          message: AppStrings.accountActivationRequestFailedTitle);
    }
  }

  @override
  void dispose() {
    _mobileTEController.dispose();
    _transTEController.dispose();
    super.dispose();
  }
}
