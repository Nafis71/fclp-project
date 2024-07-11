import 'package:fclp_app/services/network_request.dart';
import 'package:fclp_app/utils/network_urls.dart';

class AirTicketService {
  static Future<Object> getAirportList(String token) async {
    return await NetworkRequest().getRequest(
        url: NetworkUrls.getAirportListUrl,
        headers: {"Authorization": "Bearer $token"});
  }
}
