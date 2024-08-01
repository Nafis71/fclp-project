import 'package:fclp_app/Controllers/form_validation_controller.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      appBar: customAppBar(title: "Redeem Points"),
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
                height: 40,
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
                      validator: FormValidationController.validatePoints,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 5
                      ),
                      onPressed: (){
                      if(_formKey.currentState!.validate()){

                      }
                    }, child: const Text("উত্তোলন করুন"),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mobileTEController.dispose();
    _pointTEController.dispose();
    super.dispose();
  }
}
