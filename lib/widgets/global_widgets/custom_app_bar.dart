import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

AppBar customAppBar() {
  return AppBar(
    title: const Text("FCLP"),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.notifications_outlined,size: 30,),
      ),
    ],
  );
}
