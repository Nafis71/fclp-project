import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

InkWell buildPaymentInfoSection({
  required BuildContext context,
  required String leadingIcon,
  required IconData trailingIcon,
  required String title,
  required VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      color: AppColors.white,
      child: ListTile(
        leading: SizedBox(
          height: 30,
          width: 30,
          child: Image.asset(
            leadingIcon,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.green,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          trailingIcon,
          color: AppColors.green,
          size: 30,
        ),
      ),
    ),
  );
}
