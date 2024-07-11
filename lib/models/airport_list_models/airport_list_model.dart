import 'package:fclp_app/models/airport_list_models/airport_data.dart';

class AirportListModel {
  String? message;
  List<AirportData>? airportData;

  AirportListModel({this.message, this.airportData});

  AirportListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      airportData = <AirportData>[];
      json['data'].forEach((v) {
        airportData!.add(AirportData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (airportData != null) {
      data['data'] = airportData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
