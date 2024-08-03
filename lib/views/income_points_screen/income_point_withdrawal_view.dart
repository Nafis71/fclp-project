import 'package:fclp_app/Controllers/form_validation_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../utils/color_palette.dart';
import '../../widgets/profile_widgets/form_input_decoration.dart';

class IncomePointWithdrawalView extends StatefulWidget {
  final String paymentMethod;

  const IncomePointWithdrawalView({super.key, required this.paymentMethod});

  @override
  State<IncomePointWithdrawalView> createState() =>
      _IncomePointWithdrawalViewState();
}

class _IncomePointWithdrawalViewState extends State<IncomePointWithdrawalView> {
  late final TextEditingController _mobileTEController;
  late final TextEditingController _pointTEController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _mobileTEController = TextEditingController();
    _pointTEController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Redeem Points", context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Center(
                child: SvgPicture.asset(
                  AssetsPaths.redeemPoints,
                  width: 250,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: AppColors.secondaryThemeColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                          child: Icon(
                        Icons.info,
                        size: 28,
                        color: AppColors.themeColor,
                      )),
                      const Expanded(
                        flex: 8,
                        child: Text(
                            "আপনার পয়েন্টগুলি টাকা হিসাবে পাঠাতে সর্বোচ্চ ১/২ কর্মদিবস সময় লাগতে পারে।"),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      cursorColor: AppColors.themeColor,
                      controller: _mobileTEController,
                      keyboardType: TextInputType.text,
                      decoration: formInputDecoration(
                        hintText:
                            "আপনার ${widget.paymentMethod.toUpperCase()} মোবাইল নম্বর",
                      ),
                      validator: (widget.paymentMethod == "bkash")
                          ? FormValidationController.validateBkashNumber
                          : FormValidationController.validateNagadNumber,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorColor: AppColors.themeColor,
                      controller: _pointTEController,
                      keyboardType: TextInputType.number,
                      decoration: formInputDecoration(
                        hintText: "পয়েন্ট সংখ্যা",
                      ),
                      validator: (points) {
                        return FormValidationController.validatePoints(
                          points,
                          int.parse(
                            context.read<ProfileController>().userData.points,
                          ),
                        );
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Consumer<ProfileController>(
                        builder: (_, profileController, __) {
                      if (profileController.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.themeColor,
                          ),
                        );
                      }
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 5),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            redeemPoint(profileController);
                          }
                        },
                        child: const Text("উত্তোলন করুন"),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> redeemPoint(ProfileController profileController) async {
    bool status = await profileController.redeemPoint(
      int.parse(_pointTEController.text.trim()),
      widget.paymentMethod,
      _mobileTEController.text.trim(),
    );
    if (status && mounted) {
      snackBarMessage(
        context: context,
        message: AppStrings.redeemPointSuccessMessage,
      );
      Navigator.pop(context);
      return;
    }
    if (mounted) {
      warningDialog(
        context: context,
        warningDescription: AppStrings.redeemPointFailureMessage,
        message: AppStrings.redeemPointFailureTitle,
      );
    }
  }

  @override
  void dispose() {
    _mobileTEController.dispose();
    _pointTEController.dispose();
    super.dispose();
  }
}
