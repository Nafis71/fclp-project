import 'package:fclp_app/services/network_request.dart';
import 'package:fclp_app/utils/network_urls.dart';

class AirTicketService {
  static Future<Object> getAirportList(String token) async {
    print(token);
    return await NetworkRequest().getRequest(
        url: NetworkUrls.getAirportListUrl,
        headers: {"Authorization": "Bearer $token"});
  }

  static Future<Object> bookAirTicket(
      String token, Map<String, dynamic> ticketData) async {
    return await NetworkRequest().postRequest(
        url: NetworkUrls.bookTicketUrl,
        body: ticketData,
        headers: {
          "Authorization": "Bearer $token",
          "content-type": "application/json"
        });
  }

  static Future<Object> getTicketList(String token) async {
    return await NetworkRequest().getRequest(
        url: NetworkUrls.ticketUrl,
        headers: {"Authorization": "Bearer $token"});
  }
}
