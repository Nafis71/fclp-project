import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar customAppBar() {
  return AppBar(
    centerTitle: false,
    title: const Text("FCLP"),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(EvaIcons.bellOutline,size: 29,),
      ),
    ],
  );
}
