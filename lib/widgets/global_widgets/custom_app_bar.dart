import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

AppBar customAppBar({String? title}) {
  return AppBar(
    centerTitle: false,
    title: (title == null) ? const Text("FCLP") : Text(title),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          EvaIcons.bellOutline,
          size: 29,
        ),
      ),
    ],
  );
}
