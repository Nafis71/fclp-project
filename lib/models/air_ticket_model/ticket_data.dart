import 'package:fclp_app/models/air_ticket_model/transit.dart';

class TicketData {
  int? id;
  String? start;
  String? end;
  String? travelDate;
  String? types;
  String? person;
  String? price;
  String? userId;
  String? status;
  String? notice;
  String? createdAt;
  String? updatedAt;
  Transit? from;
  Transit? to;
  String? departureShort;
  String? arrivalShort;
  String? nid;
  String? passport;

  TicketData(
      {this.id,
      this.start,
      this.end,
      this.travelDate,
      this.types,
      this.person,
      this.price,
      this.userId,
      this.status,
      this.notice,
      this.createdAt,
      this.updatedAt,
      this.from,
      this.to,
      this.nid,
      this.passport});

  TicketData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
    travelDate = json['travel_date'];
    types = json['types'];
    person = json['person'];
    price = json['price'];
    userId = json['user_id'];
    status = json['status'];
    notice = json['notice'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    from = json['from'] != null ? Transit.fromJson(json['from']) : null;
    to = json['to'] != null ? Transit.fromJson(json['to']) : null;
    nid = json['nid'];
    passport = json['passport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ticketData = <String, dynamic>{};
    ticketData['id'] = id;
    ticketData['start'] = start;
    ticketData['end'] = end;
    ticketData['travel_date'] = travelDate;
    ticketData['types'] = types;
    ticketData['person'] = person;
    ticketData['price'] = price;
    ticketData['user_id'] = userId;
    ticketData['status'] = status;
    ticketData['notice'] = notice;
    ticketData['created_at'] = createdAt;
    ticketData['updated_at'] = updatedAt;
    if (from != null) {
      ticketData['from'] = from!.toJson();
    }
    if (to != null) {
      ticketData['to'] = to!.toJson();
    }
    return ticketData;
  }
}
