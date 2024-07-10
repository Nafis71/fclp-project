import 'package:fclp_app/Controllers/auth_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/constants.dart';
import 'package:fclp_app/views/main_bottom_nav_view.dart';
import 'package:fclp_app/views/order_confirmation_view.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormValidationController {
  static String? validateMobileNumber(String? mobileNumber) {
    if (mobileNumber == null || mobileNumber.isEmpty) {
      return 'আপনার মোবাইল নাম্বারটি লিখুন।';
    } else if (!AppConstants.mobileNumberRegExp.hasMatch(mobileNumber)) {
      return 'আপনার মোবাইল নাম্বারটি সঠিক নয়।';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'আপনার পাসওয়ার্ড লিখুন।';
    } else if (!AppConstants.passwordRegExp.hasMatch(password)) {
      return 'পাসওয়ার্ড কমপক্ষে 8 অক্ষর দীর্ঘ হতে হবে এবং একটি বড় হাতের অক্ষর, একটি ছোট হাতের অক্ষর, একটি সংখ্যা এবং একটি বিশেষ অক্ষর অন্তর্ভুক্ত করতে হবে';
    }
    return null;
  }

  static String? validateEmail(String? emailAdress) {
    if (emailAdress == null || emailAdress.isEmpty) {
      return 'আপনার ইমেইল লিখুন।';
    } else if (!AppConstants.emailRegExp.hasMatch(emailAdress)) {
      return 'আপনার ইমেইলটি সঠিক নয়।';
    }
    return null;
  }

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'ব্যবহারকারীর নাম অবশ্যই দিতে হবে।';
    } else if (!AppConstants.nameRegExp.hasMatch(name)) {
      return 'নাম শুধুমাত্র অক্ষর এবং স্পেস অন্তর্ভুক্ত করতে পারে।';
    }
    return null;
  }

  static String? validateBkashNumber(String? number) {
    if (number == null || number.isEmpty) {
      return 'আপনার bKash নাম্বারটি লিখুন।';
    } else if (!AppConstants.withdrawNumberRegExp.hasMatch(number)) {
      return 'আপনার bKash নাম্বারটি সঠিক নয়।';
    }
    return null;
  }

  static String? validateBkashAmount(String? amount) {
    if (amount == null || amount.isEmpty) {
      return 'পরিমান লিখুন।';
    } else if (!AppConstants.withdrawAmountRegExp.hasMatch(amount)) {
      return 'পরিমানটি সঠিক নয়। সর্বনিম্ন পরিমান ১০০ টাকা হতে হবে।';
    }
    return null;
  }

  static String? validateNagadNumber(String? number) {
    if (number == null || number.isEmpty) {
      return 'আপনার Nagad নাম্বারটি লিখুন।';
    } else if (!AppConstants.withdrawNumberRegExp.hasMatch(number)) {
      return 'আপনার Nagad নাম্বারটি সঠিক নয়।';
    }
    return null;
  }

  static String? validateNagadAmount(String? amount) {
    if (amount == null || amount.isEmpty) {
      return 'পরিমান লিখুন।';
    } else if (!AppConstants.withdrawAmountRegExp.hasMatch(amount)) {
      return 'পরিমানটি সঠিক নয়। সর্বনিম্ন পরিমান ১০০ টাকা হতে হবে।';
    }
    return null;
  }

  static String? validateAddress(String? address) {
    {
      if (address == null || address.isEmpty) {
        return 'আপনার ঠিকানা লিখুন';
      }
      if (!AppConstants.addressRegExp.hasMatch(address)) {
        return 'আপনার ঠিকানা সঠিক নয়।';
      }
      return null;
    }
  }

  static void handleLogin(BuildContext context, GlobalKey<FormState> formKey,
      String mobile, String password) async {
    if (formKey.currentState!.validate()) {
      bool status =
          await context.read<AuthController>().signIn(mobile, password);

      if (status && context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainBottomNavView(),
          ),
          (route) => false,
        );
        return;
      }
      if (context.mounted) {
        warningDialog(
          context: context,
          warningDescription: AppStrings.unAuthorizedLoginError,
        );
      }
    } else {
      warningDialog(
        context: context,
        warningDescription: 'মোবাইল নাম্বার এবং পাসওয়ার্ড অবশ্যই দিতে হবে।',
      );
    }
  }

  static void handleDeliveryNextStep(
    BuildContext context,
    GlobalKey<FormState> formKey,
  ) {
    if (formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderConfirmationView(),
        ),
      );
    } else {
      warningDialog(
        context: context,
        warningDescription:
            ' "আপনাকে অবশ্যই গ্রাহকের নাম, সম্পূর্ণ ঠিকানা এবং ফোণ ন্মাবার দিতে হবে।",',
      );
    }
  }

  static void handleSave(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController mobileNumberController,
  ) {
    final profileController =
        Provider.of<ProfileController>(context, listen: false);
    if (formKey.currentState!.validate()) {
      profileController.setName(nameController.text);
      profileController.setEmail(emailController.text);
      profileController.setMobileNumber(mobileNumberController.text);
      snackBarMessage(context: context, message: "Edited");
      nameController.clear();
      emailController.clear();
      mobileNumberController.clear();
      profileController.toggleEdit();
    }
  }
}
