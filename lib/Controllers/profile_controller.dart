import 'dart:convert';
import 'dart:io';
import 'package:fclp_app/models/user_model/user.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:fclp_app/services/user_profile_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  bool _isEdit = false;
  String _token = "";
  String _base64Image = "";
  late User userData;
  Object? response;
  final ImagePicker _imagePicker = ImagePicker();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  String get base64Image => _base64Image;


  bool get isEdit => _isEdit;


  String get token => _token;

  void toggleEdit() {
    _isEdit = !_isEdit;
    notifyListeners();
  }



  void setResetBase64Image() {
    _base64Image = "";
    _isEdit = false;
  }
  void setToken(String token) {
    _token = token;
  }
  Future<void> pickImage() async {
    XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      convertImage(pickedFile);
    }
  }

  void convertImage(XFile pickedFile) {
    List<int> imageBytes = File(pickedFile.path).readAsBytesSync();
    _base64Image = base64Encode(imageBytes);
    notifyListeners();
  }

  Future<bool> updateProfile({required String email,
    required String mobile,
    required String name}) async {
    setIsLoading = true;
    if(base64Image.isNotEmpty){
      userData.image = base64Image;
    }
    print(userData.image);
    response = await UserProfileService.updateProfile(_token, userData.id.toString(), userData);
    if(response is Success){
      await saveUserData(name,mobile,email);
      setIsLoading = false;
      return true;
    }
    return false;
  }

  Future<void> saveUserData(String name, String mobile,String email) async{
   userData.name = name;
   userData.mobile = mobile;
   userData.email = email;
   SharedPreferences preferences = await SharedPreferences.getInstance();
   preferences.setString("userData", jsonEncode(userData.toJson()));
  }
}
