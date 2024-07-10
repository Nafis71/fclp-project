import 'package:fclp_app/utils/color_palette.dart';
import 'package:fclp_app/widgets/profile_widgets/form_input_decoration.dart';
import 'package:flutter/material.dart';

Form passwordSection({
  required GlobalKey formKey,
  required TextEditingController newPasswordController,
  required TextEditingController confirmPasswordController,
  required VoidCallback saveNewPassword,
}) {
  return Form(
    key: formKey,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "নতুন পাসওয়ার্ড",
          style: TextStyle(
            color: AppColors.themeColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: newPasswordController,
          decoration: formInputDecoration(
            hintText: "নতুন পাসওয়ার্ড",
          ),
          validator: (String? newPassword) {
            if (newPassword?.isEmpty ?? true) {
              return "পাসওয়ার্ড অবশ্যই দিতে হবে।";
            }
            if (newPassword!.length < 6) {
              return "পাসওয়ার্ড মিনিমাম ৬ ডিজিটের হতে হবে।";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 8,
        ),
        const Text(
          "কনফার্ম পাসওয়ার্ড",
          style: TextStyle(
            color: AppColors.themeColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextFormField(
          controller: confirmPasswordController,
          decoration: formInputDecoration(hintText: "কনফার্ম পাসওয়ার্ড"),
          validator: (String? confirmPassowrd) {
            if (confirmPassowrd?.isEmpty ?? true) {
              return "পাসওয়ার্ড অবশ্যই দিতে হবে।";
            } else if (confirmPassowrd!.length < 6) {
              return "পাসওয়ার্ড মিনিমাম ৬ ডিজিটের হতে হবে।";
            }
            return null;
          },
        ),
        const SizedBox(
          height: 16,
        ),
        ElevatedButton(
          onPressed: saveNewPassword,
          child: const Text(
            "পাসওয়ার্ড সংরক্ষন করুন",
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    ),
  );
}
