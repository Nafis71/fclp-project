class AppConstants {
  static RegExp mobileNumberRegExp = RegExp(r'^(?:\+?88)?01[3-9]\d{8}$');

  static RegExp withdrawNumberRegExp = RegExp(r'^(01[3-9]\d{8})$');

  static RegExp withdrawAmountRegExp = RegExp(r'^[0-9]+$');

  static RegExp passwordRegExp = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

  static RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');

  static RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

  static RegExp addressRegExp = RegExp(r'^[a-zA-Z0-9\s,.-]+$');

  static const String phoneNumber = "+8801610658696";
}
