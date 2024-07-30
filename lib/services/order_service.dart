import 'package:fclp_app/services/network_request.dart';
import 'package:fclp_app/utils/network_urls.dart';

class OrderService {
  static Future<Object> getOrderList(String token) async {
    return await NetworkRequest().getRequest(
      url: NetworkUrls.orderList,
      headers: {"Authorization": "Bearer $token"},
    );
  }

  static Future<Object> storeDeliveryInfo(
      String token, Map<String, String> deliveryInfo) async {
    return await NetworkRequest().postRequest(
      url: NetworkUrls.confirmDeliveryCost,
      headers: {"Authorization": "Bearer $token","content-type":"Application/json"},
      body: deliveryInfo,
    );
  }
  static Future<Object> storeDeliveryPaymentInfo(
      String token, Map<String, dynamic> paymentInfo) async {
    return await NetworkRequest().postRequest(
      url: NetworkUrls.payDeliveryCost,
      headers: {"Authorization": "Bearer $token","content-type":"Application/json"},
      body: paymentInfo,
    );
  }
}
