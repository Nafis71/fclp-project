import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

AppBar customAppBar() {
  return AppBar(
    surfaceTintColor: AppColors.white,
    title: const Text("FCLP"),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_outlined),
      ),
    ],
  );
}
