import 'package:fclp_app/Controllers/form_validation_controller.dart';
import 'package:fclp_app/themes/theme.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DeliveryAddressFormView extends StatefulWidget {
  const DeliveryAddressFormView({super.key});

  @override
  State<DeliveryAddressFormView> createState() =>
      _DeliveryAddressFormViewState();
}

class _DeliveryAddressFormViewState extends State<DeliveryAddressFormView> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _addressTEController = TextEditingController();
  final TextEditingController _phoneTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const Text(
                  "সরবরাহের ঠিকানা",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: "BlackOpsOne",
                    color: AppColors.themeColor,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _nameTEController,
                  decoration: textFormInputDecoration(hintText: "গ্রাহকের নাম"),
                  validator: FormValidationController.validateName,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _addressTEController,
                  decoration: textFormInputDecoration(
                    hintText: "গ্রাহকের সম্পূর্ণ ঠিকানা",
                  ),
                  maxLines: 4,
                  validator: FormValidationController.validateAddress,
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _phoneTEController,
                  keyboardType: TextInputType.number,
                  decoration:
                      textFormInputDecoration(hintText: "গ্রাহকের ফোন নাম্বার"),
                  validator: FormValidationController.validateMobileNumber,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () =>
                      FormValidationController.handleDeliveryNextStep(
                          context, _formKey),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("পরবর্তী ধাপে যান"),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _addressTEController.dispose();
    _phoneTEController.dispose();
    super.dispose();
  }
}
