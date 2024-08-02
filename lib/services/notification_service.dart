import 'package:fclp_app/services/network_request.dart';
import 'package:fclp_app/utils/network_urls.dart';

class NotificationService {
  static Future<Object> getAllNotification(String token) async {
    return NetworkRequest().getRequest(
      url: NetworkUrls.notificationUrl,
      headers: {"Authorization": "Bearer $token"},
    );
  }
}
