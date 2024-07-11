import 'dart:convert';

import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/models/user_model/user.dart';
import 'package:fclp_app/models/user_model/user_model.dart';
import 'package:fclp_app/services/auth_service.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  Object? response;
  bool _finalResponse = false;
  bool _isLoading = false;
  bool _isLoginScreen = true;

  bool get isLoginScreen => _isLoginScreen;

  void setIsLoginScreen(bool value) {
    _isLoginScreen = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> signIn(String mobile, String password,
      ProfileController profileController) async {
    _finalResponse = false;
    setIsLoading = true;
    Map<String, String> credentials = {
      "mobile": mobile,
      "password": password,
    };
    response = await AuthService.signInUser(credentials);
    if (response is Success) {
      Map<String, dynamic> jsonData =
          (response as Success).response as Map<String, dynamic>;
      String? token = jsonData['token'];
      if (token != null) {
        response = await AuthService.getAllUser(token);
        if (response is Success) {
          User? userData = await loadUserData(mobile, profileController);
          if(userData != null){
            saveUserData(userData,token, profileController);
          }

          _finalResponse = true;
        }
      }
    }
    setIsLoading = false;
    return _finalResponse;
  }

  Future<User?> loadUserData(
      String mobile, ProfileController profileController) async {
    UserModel userModel = UserModel.fromJson(
        (response as Success).response as Map<String, dynamic>);
    if (userModel.user != null) {
      for (User user in userModel.user!) {
        if (user.mobile == mobile) {
          return user;
        }
      }
    }
    return null;
  }

  Future<bool> registration(Map<String, String> userData) async {
    _finalResponse = false;
    setIsLoading = true;
    response = await AuthService.registerUser(userData);
    if (response is Success) {
      _finalResponse = true;
    }
    setIsLoading = false;
    return _finalResponse;
  }

  Future<void> saveUserData(
      User userData, String token, ProfileController profileController) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("userData", jsonEncode(userData.toJson()));
    preferences.setString("token", token);
    profileController.setMobileNumber(userData.mobile.toString());
    profileController.setEmail(userData.email.toString());
    profileController.setName(userData.name.toString());
    profileController.setToken(token);
  }
}
