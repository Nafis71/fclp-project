import 'package:fclp_app/Controllers/form_validation_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:flutter/material.dart';

class BusinessAccountLoginFormSection extends StatefulWidget {
  const BusinessAccountLoginFormSection({super.key});

  @override
  State<BusinessAccountLoginFormSection> createState() =>
      _BusinessAccountLoginFormSectionState();
}

class _BusinessAccountLoginFormSectionState
    extends State<BusinessAccountLoginFormSection> {
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  bool passwordVisibility = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.green,
          width: 3,
        ),
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.textFormFieldBorderColor,
                        width: 2,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: _mobileTEController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "মোবাইল নাম্বার",
                      prefixIcon: Icon(
                        Icons.phone_outlined,
                        size: 30,
                      ),
                    ),
                    validator: FormValidationController.validateMobileNumber,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.textFormFieldBorderColor,
                        width: 2,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: _passwordTEController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: passwordVisibility,
                    decoration: InputDecoration(
                      hintText: "পাসওয়ার্ড",
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        size: 30,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              passwordVisibility = !passwordVisibility;
                            });
                          }
                        },
                        child: passwordVisibility == true
                            ? const Icon(
                                Icons.visibility_off,
                                size: 30,
                              )
                            : const Icon(
                                Icons.visibility,
                                size: 30,
                              ),
                      ),
                    ),
                    validator: FormValidationController.validatePassword,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "পাসওয়ার্ড ভুলে গেছেন?",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () => FormValidationController.handleLogin(
                      context,
                      _formKey,
                      _mobileTEController.text.trim(),
                      _passwordTEController.text),
                  child: const Text("লগইন করুন"),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "এখনো একাউন্ট করেন নি?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                OutlinedButton(
                  onPressed: () {
                    warningDialog(
                      context: context,
                      warningDescription:
                          "মোবাইল নাম্বার এবং পাসওয়ার্ড অবশ্যই দিতে হবে।",
                    );
                  },
                  child: const Text("রেজিস্ট্রেশন করুন"),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
