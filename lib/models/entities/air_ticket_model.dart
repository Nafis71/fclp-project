class AirTicketModel {
  Map<String, String> departureAirport;
  Map<String, String> arrivalAirport;
  String travelDateTime;
  String ticketType;
  String traveller;

  AirTicketModel({
    required this.departureAirport,
    required this.arrivalAirport,
    required this.travelDateTime,
    required this.ticketType,
    required this.traveller,
  });
}
