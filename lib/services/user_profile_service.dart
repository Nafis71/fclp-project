import 'package:fclp_app/models/user_model/user.dart';
import 'package:fclp_app/services/network_request.dart';
import 'package:fclp_app/utils/network_urls.dart';

class UserProfileService {
  static Future<Object> updateProfile(
      String token, String id, User userModel) async {
    return await NetworkRequest().putRequest(
        url: "${NetworkUrls.userUpdateUrl}/$id",
        headers: {
          "Authorization": "Bearer $token",
          "content-type": "Application/json"
        },
        body: userModel.toJsonUpdateProfile());
  }

  static Future<Object> accountActiveRequest(
      String token, Map<String, String> transactionDetails) async {
    return await NetworkRequest().postRequest(
        url: NetworkUrls.accountActiveRequest,
        body: transactionDetails,
        headers: {
          "Authorization": "Bearer $token",
          "content-type": "Application/json"
        });
  }

  static Future<Object> checkActivationStatus(String token) async {
    return await NetworkRequest().getRequest(
        url: NetworkUrls.getUserUrl,
        headers: {"Authorization": "Bearer $token"});
  }

  static Future<Object> getReferrals(String token) async {
    return await NetworkRequest().getRequest(
      url: NetworkUrls.referrals,
      headers: {"Authorization": "Bearer $token"},
    );
  }
}
