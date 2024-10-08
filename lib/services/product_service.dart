import 'package:fclp_app/services/network_request.dart';
import 'package:fclp_app/utils/network_urls.dart';

class ProductService {
  static Future<Object> getAllProductList(String page, String token) async {
    return await NetworkRequest().getRequest(
      url: "${NetworkUrls.productUrl}$page",
      headers: {
        "Authorization": "Bearer $token",
      },
    );
  }

  static Future<Object> addToCart(
      String token, Map<String, String> productData) async {
    return await NetworkRequest().postRequest(
      url: NetworkUrls.cartStoreUrl,
      headers: {
        "Authorization": "Bearer $token",
        "content-type": "Application/json"
      },
      body: productData,
    );
  }

  static Future<Object> getCartData(String token) async {
    return await NetworkRequest().getRequest(
      url: NetworkUrls.cartListUrl,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
  }

  static Future<Object> deleteCartItem(String token, String productId) async {
    return await NetworkRequest().deleteRequest(
        url: "${NetworkUrls.cartDeleteUrl}/$productId",
        headers: {"Authorization": "Bearer $token"});
  }

  static Future<Object> cartToOrder(String token) async {
    return await NetworkRequest().postRequest(
        url: NetworkUrls.cartToOrder,
        headers: {"Authorization": "Bearer $token"});
  }

  static Future<Object> getCategoryList(String token) async {
    return await NetworkRequest().getRequest(
        url: NetworkUrls.productCategoryLink,
        headers: {"Authorization": "Bearer $token"});
  }

}
