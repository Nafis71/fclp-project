import 'package:fclp_app/Controllers/auth_controller.dart';
import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/services/response/Failure.dart';
import 'package:fclp_app/utils/app_strings.dart';
import 'package:fclp_app/utils/constants.dart';
import 'package:fclp_app/views/main_bottom_nav_view.dart';
import 'package:fclp_app/views/non_authorized_screen/non_authorized_screen.dart';
import 'package:fclp_app/views/order_confirmation_view.dart';
import 'package:fclp_app/widgets/global_widgets/snack_bar_message.dart';
import 'package:fclp_app/widgets/global_widgets/warning_dialog.dart';
import 'package:fclp_app/widgets/profile_widgets/profile_edit_view.dart';
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

  static String? validateConfirmPassword(
      String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'আপনার পাসওয়ার্ড লিখুন।';
    } else if (!AppConstants.passwordRegExp.hasMatch(confirmPassword)) {
      return 'পাসওয়ার্ড কমপক্ষে 8 অক্ষর দীর্ঘ হতে হবে এবং একটি বড় হাতের অক্ষর, একটি ছোট হাতের অক্ষর, একটি সংখ্যা এবং একটি বিশেষ অক্ষর অন্তর্ভুক্ত করতে হবে';
    } else if (password != confirmPassword) {
      return "পাসওয়ার্ড মেলেনি";
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
      bool status = await context
          .read<AuthController>()
          .signIn(mobile, password, context.read<ProfileController>());
      if (status && context.mounted) {
        WidgetBuilder? widgetBuilder;
        if (context.read<ProfileController>().userData.status == "0" ||
            context.read<ProfileController>().userData.status == "2") {
          widgetBuilder = (context) => const NonAuthorizedScreen();
        } else {
          widgetBuilder = (context) => const MainBottomNavView();
        }
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: widgetBuilder,
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

  static void handleRegistration(
      {required BuildContext context,
      required GlobalKey<FormState> formKey,
      required String name,
      required String email,
      required String mobile,
      required String password,
      required String confirmPassword}) async {
    if (formKey.currentState!.validate()) {
      Map<String, String> userData = {
        "name": name,
        "email": email,
        "mobile": mobile,
        "password": password,
        "image": "",
        "password_confirmation": confirmPassword
      };
      bool status = await context.read<AuthController>().registration(userData);

      if (status && context.mounted) {
        snackBarMessage(
            message: AppStrings.registrationSuccessMessage, context: context);
        context.read<AuthController>().setIsLoginScreen(true);
        return;
      }
      if (context.mounted) {
        int statusCode =
            (context.read<AuthController>().response as Failure).statusCode;
        if (statusCode == 400) {
          warningDialog(
            context: context,
            message: AppStrings.registrationFailureTitle,
            warningDescription: AppStrings.duplicateRegistrationFailureMessage,
          );
          return;
        }
        warningDialog(
          context: context,
          message: AppStrings.registrationFailureTitle,
          warningDescription: AppStrings.registrationFailureMessage,
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

  static String? validateNID(String? value) {
    if (value!.isEmpty) {
      return "অনুগ্রহ করে NID লিখুন";
    }
    return null;
  }

  static Future<void> handleSave(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController nameController,
    TextEditingController emailController,
    TextEditingController mobileNumberController,
  ) async {
    if (formKey.currentState!.validate()) {
      bool status = await context.read<ProfileController>().updateProfile(
          email: emailController.text.trim(),
          mobile: mobileNumberController.text.trim(),
          name: nameController.text.trim());
      if (status && context.mounted) {
        snackBarMessage(
            context: context, message: AppStrings.profileUpdateSuccessMessage);
        context.read<ProfileController>().toggleEdit();
        return;
      }
      if (context.mounted) {
        warningDialog(
            context: context,
            warningDescription: AppStrings.profileUpdateFailureMessage,
            message: AppStrings.profileUpdateFailureTitle);
      }
    }
  }
}
