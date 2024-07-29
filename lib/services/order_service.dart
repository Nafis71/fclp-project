import 'package:fclp_app/services/network_request.dart';
import 'package:fclp_app/utils/network_urls.dart';

class OrderService {
  static Future<Object> getOrderList(String token) async {
    return await NetworkRequest().getRequest(
      url: NetworkUrls.orderList,
      headers: {"Authorization": "Bearer $token"},
    );
  }
}
