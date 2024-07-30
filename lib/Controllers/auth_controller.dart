import 'dart:convert';

import 'package:fclp_app/Controllers/profile_controller.dart';
import 'package:fclp_app/models/user_model/user.dart';
import 'package:fclp_app/models/user_model/user_model.dart';
import 'package:fclp_app/services/auth_service.dart';
import 'package:fclp_app/services/response/Failure.dart';
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
        User? userData = User.fromJson(jsonData['user']);
        await saveUserData(userData, token, profileController);
        _finalResponse = true;
      }
    }
    setIsLoading = false;
    return _finalResponse;
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

  Future<bool> changePassword(String mobile, String password,
      ProfileController profileController) async {
    _finalResponse = false;
    setIsLoading = true;
    Map<String, String> credentials = {
      "mobile": mobile,
      "password": password,
    };
    response = await AuthService.changePassword(credentials);
    if (response is Success) {
      Map<String, dynamic> jsonData =
          (response as Success).response as Map<String, dynamic>;
      profileController.setToken(jsonData['token']);
      _finalResponse = true;
    }
    setIsLoading = false;
    return _finalResponse;
  }

  Future<void> logoutUser(String token) async {
    response = await AuthService.logout(token);
    if (response is Failure) {
      if (kDebugMode) {
        debugPrint("Couldn't logout");
      }
    }
  }

  Future<void> saveUserData(
      User userData, String token, ProfileController profileController) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("userData", jsonEncode(userData.toJson()));
    preferences.setString("token", token);
    profileController.userData = userData;
    profileController.setToken(token);
  }
}
