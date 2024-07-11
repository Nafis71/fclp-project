import 'package:fclp_app/models/airport_list_models/airport_data.dart';
import 'package:fclp_app/models/airport_list_models/airport_list_model.dart';
import 'package:fclp_app/models/entities/air_ticket_model.dart';
import 'package:fclp_app/services/air_ticket_service.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:flutter/material.dart';

class AirTicketController extends ChangeNotifier {
  late Object response;
  List<Map<String, String>> airports = [];

  Map<String, String> departureAirport = {};
  Map<String, String> arrivalAirport = {};
  String travelDateTime = '';
  String ticketType = '';
  String traveller = '';
  bool isAirTicketApplyFormFilled = false;
  List<AirTicketModel> airTicketFormInfo = [];
  bool _isLoading = false;
  bool _finalResponse = false;

  List<String> typeOfTicket = [
    "ইকোনমি",
    "বিজনেস",
    "প্রিমিয়াম",
    "ফার্স্ট ক্লাস"
  ];
  String ticket = "ফার্স্ট ক্লাস";
  List<String> travellers = [
    "1 জন",
    "2 জন",
    "3 জন",
    "4 জন",
    "5 জন",
    "6 জন",
    "7 জন",
    "8 জন",
    "9 জন"
  ];
  String countOfTravellers = "1 জন";
  String date = "01/01/2000";

  bool get isLoading => _isLoading;




  Future<void> datePicked(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      date = "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
      if (isAirTicketApplyFormFilled) {

      }
      notifyListeners();
    }
  }



  set setIsLoading (bool isLoading){
    _isLoading = isLoading;
    notifyListeners();
  }



  Future<bool> loadAirportList(String token) async {
    setIsLoading = true;
    response = await AirTicketService.getAirportList(token);
    if (response is Success) {
      AirportListModel airportListModel = AirportListModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      if (airportListModel.airportData != null) {
        for (AirportData airportData in airportListModel.airportData!) {
          airports.add(
            {
              "id": airportData.id.toString(),
              "place": airportData.divisionName.toString(),
              "airport": airportData.airportName.toString(),
            },
          );
        }
      }
      _finalResponse = true;
    }
    setIsLoading = false;
    return _finalResponse;
  }
}
