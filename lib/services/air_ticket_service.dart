import 'package:fclp_app/services/network_request.dart';
import 'package:fclp_app/utils/network_urls.dart';

class AirTicketService {
  static Future<Object> getAirportList(String token) async {
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

  static Future<Object> deleteAirTicket(String token, String ticketId) async {
    return await NetworkRequest().deleteRequest(
        url: "${NetworkUrls.airTicketDeleteUrl}/$ticketId",
        headers: {"Authorization": "Bearer $token"});
  }

  static Future<Object> updateAirTicket(
      String token, String ticketId, Map<String, dynamic> ticketData) async {
    return await NetworkRequest().putRequest(
        url: "${NetworkUrls.airTicketUpdateUrl}/$ticketId",
        headers: {
          "Authorization": "Bearer $token",
          "content-type": "Application/json"
        },
        body: ticketData);
  }
}
