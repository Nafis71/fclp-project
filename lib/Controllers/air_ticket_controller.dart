import 'package:fclp_app/models/entities/air_ticket_model.dart';
import 'package:flutter/material.dart';

class AirTicketController extends ChangeNotifier {
  List<Map<String, String>> airports = [
    {
      'place': 'Dhaka',
      'airport': 'DHK (Dhaka International Airport)',
    },
    {
      'place': 'Chittagong',
      'airport': 'CTS (Shash Amanat International Airport)',
    },
    {
      'place': 'Sylhet',
      'airport': 'ZYL (Osmani International Airport)',
    },
    {
      'place': 'Cox\'s Bazar',
      'airport': 'CXB (Cox\'s Bazar International Airport)',
    },
    {
      'place': 'Saidpur',
      'airport': 'SPD (Saidpur Airport)',
    },
    {
      'place': 'Rajshahi',
      'airport': 'RJH (Rajshahi Airport)',
    },
  ];

  Map<String, String> selectedDepartureAirport = {};
  Map<String, String> selectedArrivalAirport = {};

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

  Future<void> datePicked(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      date = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      if (isAirTicketApplyFormFilled) {
        updateTravelDateTime(date);
      }
      notifyListeners();
    }
  }

  Map<String, String> departureAirport = {};
  Map<String, String> arrivalAirport = {};
  String travelDateTime = '';
  String ticketType = '';
  String traveller = '';
  bool isAirTicketApplyFormFilled = false;
  List<AirTicketModel> airTicketFormInfo = [];

  void updateDepartureAirport(Map<String, String> departure) {
    departureAirport = departure;
    notifyListeners();
  }

  void updateArrivalAirport(Map<String, String> arrival) {
    arrivalAirport = arrival;
    notifyListeners();
  }

  void updateTravelDateTime(String dateTime) {
    travelDateTime = dateTime;
    notifyListeners();
  }

  void updateTicketType(String type) {
    ticketType = type;
    notifyListeners();
  }

  void updateTravellers(String travellersCount) {
    traveller = travellersCount;
    notifyListeners();
  }

  void updateAirTicketApplyFormFilled(bool airTicketFormFilled) {
    isAirTicketApplyFormFilled = airTicketFormFilled;
    notifyListeners();
  }
}
