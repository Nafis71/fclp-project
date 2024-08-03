import 'package:fclp_app/models/air_ticket_model/ticket_data.dart';

class AirTicketModel {
  String? message;
  List<TicketData>? ticketData;

  AirTicketModel({this.message, this.ticketData});

  AirTicketModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      ticketData = <TicketData>[];
      json['data'].forEach((v) {
        ticketData!.add(TicketData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (ticketData != null) {
      data['data'] = ticketData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
