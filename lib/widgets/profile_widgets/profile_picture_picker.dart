import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

Widget profilePicturePicker() {
  return Container(
    height: 150,
    width: 150,
    padding: const EdgeInsets.all(25),
    alignment: Alignment.bottomRight,
    decoration: const BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      image: DecorationImage(
        image: NetworkImage(
          "https://images.pexels.com/photos/1006293/pexels-photo-1006293.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        ),
        fit: BoxFit.fill,
      ),
    ),
    child: Container(
      color: AppColors.white,
      width: 60,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Edit",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.edit,
            size: 16,
          ),
        ],
      ),
    ),
  );
}
