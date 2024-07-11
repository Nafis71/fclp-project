import 'package:fclp_app/services/auth_service.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  Object? response;
  bool _finalResponse = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  onInit(){

  }

  set setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> signIn(String mobile, String password) async {
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
      if (token != null) saveToken(token);
      _finalResponse = true;
    }
    setIsLoading = false;
    return _finalResponse;
  }

  Future<void> saveToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
  }
}
