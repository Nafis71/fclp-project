import 'package:flutter/material.dart';

class AppColors {
  static Color themeColor = const Color(0xFF047451);
  static Color secondaryThemeColor = const Color(0xFFE0EEEF);
  static Color backgroundColor = Colors.white;
  static const Color green = Colors.green;
  static const Color transparent = Colors.transparent;
  static const Color red = Colors.red;
  static const Color grey = Colors.grey;
  static const Color white = Colors.white;
  static Color textFormFieldBorderColor = Colors.grey.shade100;
  static const Color deepPurple = Colors.deepPurple;
  static const Color blue = Colors.blue;
  static const Color black = Colors.black;
  static const Color amber = Colors.amber;

  static airTicketStatusColor(String status){
    Map<String,Color> statusColor ={
      "Submitted" : Colors.amber,
      "In Review" : Colors.orange,
      "Approved" : Colors.green,
      "Canceled" : Colors.red,
    };
    return statusColor[status];
  }
}
