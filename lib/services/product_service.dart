import 'package:fclp_app/services/network_request.dart';
import 'package:fclp_app/utils/network_urls.dart';

class ProductService {
  static Future<Object> getAllProductList(String page, String token) async {
    return await NetworkRequest().getRequest(
        url: "${NetworkUrls.productUrl}?$page",
        headers: {"Authorization": "Bearer $token"});
  }
}
