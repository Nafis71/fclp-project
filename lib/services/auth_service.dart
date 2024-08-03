import 'package:fclp_app/services/network_request.dart';
import 'package:fclp_app/utils/network_urls.dart';

class AuthService {
  static Future<Object> signInUser(Map<String, String> credentials) async {
    return await NetworkRequest().postRequest(
      url: NetworkUrls.loginUrl,
      body: credentials,
      headers: {
        "content-type": "Application/json",
      },
    );
  }

  static Future<Object> registerUser(Map<String, String> userData) async {
    return await NetworkRequest().postRequest(
      url: NetworkUrls.registrationUrl,
      body: userData,
      headers: {
        "content-type": "Application/json",
      },
    );
  }

  static Future<Object> changePassword(Map<String, String> credentials) async {
    return await NetworkRequest().postRequest(
        url: NetworkUrls.passwordChangeUrl,
        body: credentials,
        headers: {"content-type": "Application/json"});
  }

  static Future<Object> logout(String token) async {
    return await NetworkRequest().postRequest(
        url: NetworkUrls.logoutUrl,
        headers: {"Authorization": "Bearer $token"});
  }
}
