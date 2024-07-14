import 'package:fclp_app/Controllers/auth_controller.dart';
import 'package:fclp_app/Controllers/form_validation_controller.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/profile_widgets/form_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Form passwordSection({
  required GlobalKey formKey,
  required TextEditingController newPasswordController,
  required TextEditingController confirmPasswordController,
  required VoidCallback saveNewPassword,
}) {
  return Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "নতুন পাসওয়ার্ড",
          style: TextStyle(
            color: AppColors.themeColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: newPasswordController,
          decoration: formInputDecoration(
            hintText: "নতুন পাসওয়ার্ড",
          ),
          validator: FormValidationController.validatePassword,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "কনফার্ম পাসওয়ার্ড",
          style: TextStyle(
            color: AppColors.themeColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: confirmPasswordController,
          decoration: formInputDecoration(hintText: "কনফার্ম পাসওয়ার্ড"),
          validator: (confirmPassword) {
            return FormValidationController.validateConfirmPassword(
                newPasswordController.text, confirmPassword);
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
        const SizedBox(
          height: 16,
        ),
        Consumer<AuthController>(
          builder: (_,authController,__) {
            return Visibility(
              visible: !authController.isLoading,
              replacement: Center(child: CircularProgressIndicator(color: AppColors.themeColor,),),
              child: ElevatedButton(
                onPressed: saveNewPassword,
                child: const Text(
                  "পাসওয়ার্ড সংরক্ষন করুন",
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
        ),
      ],
    ),
  );
}
