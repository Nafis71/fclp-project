import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controllers/auth_controller.dart';
import '../../Controllers/form_validation_controller.dart';
import '../../utils/color_palette.dart';

class RegistrationWidget extends StatefulWidget {
  const RegistrationWidget({super.key});

  @override
  State<RegistrationWidget> createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  final _mobileNumberTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
  final _confirmPasswordTEController = TextEditingController();
  final _nameTEController = TextEditingController();
  final _emailTEController = TextEditingController();
  final _referTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool passwordVisibility = true;
  bool confirmPasswordVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
                            width: 2),
                      ),
                    ),
                    child: TextFormField(
                      controller: _nameTEController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        hintText: "নাম",
                        prefixIcon: Icon(
                          Icons.perm_identity,
                          size: 30,
                        ),
                      ),
                      validator: FormValidationController.validateName,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: AppColors.textFormFieldBorderColor,
                            width: 2),
                      ),
                    ),
                    child: TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "ইমেইল",
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          size: 30,
                        ),
                      ),
                      validator: FormValidationController.validateEmail,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: AppColors.textFormFieldBorderColor,
                            width: 2),
                      ),
                    ),
                    child: TextFormField(
                      controller: _mobileNumberTEController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "মোবাইল নাম্বার",
                        prefixIcon: Icon(
                          Icons.phone_outlined,
                          size: 30,
                        ),
                      ),
                      validator: FormValidationController.validateMobileNumber,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            width: 2),
                      ),
                    ),
                    child: TextFormField(
                      controller: _referTEController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "রেফার আইডি",
                        prefixIcon: Icon(
                          Icons.group_add,
                          size: 30,
                        ),
                      ),
                      validator: FormValidationController.validateReferId,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            width: 2),
                      ),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
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
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        TextFormField(
                          controller: _confirmPasswordTEController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: confirmPasswordVisibility,
                          decoration: InputDecoration(
                            hintText: "পাসওয়ার্ড নিশ্চিত করুন",
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              size: 30,
                            ),
                            suffixIcon: InkWell(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    confirmPasswordVisibility =
                                        !confirmPasswordVisibility;
                                  });
                                }
                              },
                              child: confirmPasswordVisibility == true
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
                          validator: (confirmPassword) {
                            return FormValidationController
                                .validateConfirmPassword(
                                    _passwordTEController.text,
                                    confirmPassword);
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Consumer<AuthController>(
                    builder: (_, viewModel, __) => Visibility(
                      visible: !viewModel.isLoading,
                      replacement:  CircularProgressIndicator(
                        color: AppColors.themeColor,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ElevatedButton(
                            onPressed: () =>
                                FormValidationController.handleRegistration(
                                  context: context,
                                  name: _nameTEController.text.trim(),
                                  email: _emailTEController.text.trim(),
                                  mobile: _mobileNumberTEController.text.trim(),
                                  password: _passwordTEController.text.trim(),
                                  confirmPassword:
                                      _confirmPasswordTEController.text.trim(),
                                  formKey: _formKey, referredBy: _referTEController.text.trim(),
                                ),
                            child: const Text("নিবন্ধন করুন")),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "ইতিমধ্যে অ্যাকাউন্ট আছে?",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<AuthController>().setIsLoginScreen(true);
                      },
                      child: const Text("লগইন করুন",style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _nameTEController.dispose();
    _emailTEController.dispose();
    _mobileNumberTEController.dispose();
    _referTEController.dispose();
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
