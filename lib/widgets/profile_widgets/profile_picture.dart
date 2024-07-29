import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../Controllers/profile_controller.dart';
import '../../utils/assets_paths.dart';

ImageProvider getImage(ProfileController profileController) {
  if (profileController.base64Image.isNotEmpty) {
    return MemoryImage(base64Decode(profileController.base64Image));
  }
  if (profileController.userData.base64Image.isEmpty) {
    return const AssetImage(AssetsPaths.profile);
  }
  return MemoryImage(base64Decode(profileController.userData.base64Image.toString()));
}
