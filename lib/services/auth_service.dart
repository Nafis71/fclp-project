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
}
