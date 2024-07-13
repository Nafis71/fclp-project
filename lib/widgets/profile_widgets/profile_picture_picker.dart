import 'dart:convert';

import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/utils/assets_paths.dart';
import 'package:fclp_app/utils/color_palette.dart';
import 'package:flutter/material.dart';

Widget profilePicturePicker(ProfileController profileController) {
  return Container(
    height: 150,
    width: 150,
    padding: const EdgeInsets.all(25),
    alignment: Alignment.bottomRight,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      image: DecorationImage(
        image: getImage(profileController),
        fit: BoxFit.fill,
      ),
    ),
    child: (profileController.isEdit)
        ? Container(
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
          )
        : const SizedBox.shrink(),
  );
}

ImageProvider getImage(ProfileController profileController) {
  if (profileController.base64Image.isNotEmpty) {
    return MemoryImage(base64Decode(profileController.base64Image));
  }
  if (profileController.userData.image.isEmpty) {
    print("Profile picture empty");
    return const AssetImage(AssetsPahts.profile);
  }
  print(profileController.userData.image);
  return MemoryImage(base64Decode(profileController.userData.image.toString()));
}
