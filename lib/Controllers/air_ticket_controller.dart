import 'package:fclp_app/models/air_ticket_model/air_ticket_model.dart';
import 'package:fclp_app/models/air_ticket_model/ticket_data.dart';
import 'package:fclp_app/models/airport_list_models/airport_data.dart';
import 'package:fclp_app/models/airport_list_models/airport_list_model.dart';
import 'package:fclp_app/services/air_ticket_service.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AirTicketController extends ChangeNotifier {
  Object? response;
  final List<Map<String, String>> _airports = [];
  late List<TicketData> ticketData = [];
  Map<String, String> _departureAirport = {};
  Map<String, String> _arrivalAirport = {};
  String _ticketType = 'First Class';
  String traveller = '';
  bool isAirTicketApplyFormFilled = false;
  String _uITicketType = "ফার্স্ট ক্লাস";
  final List<int> travellers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  int _countOfTravellers = 1;
  String ticketDate = "";
  String _nid = "";
  String _passport = "";
  bool _isLoading = false;
  bool _isTicketListLoading = false;
  bool _finalResponse = false;
  bool _hasTicketFound = true;
  bool _isDeletingTicket = false;
  int _deletingIndex = -1;
  int _ticketStatus = 0;
  bool _isEditMode = false;
  String _ticketId = "";
  String _ticketNotice = "No special notices";

  List<String> typeOfTicket = [
    "ইকোনমি",
    "বিজনেস",
    "প্রিমিয়াম",
    "ফার্স্ট ক্লাস"
  ];

  bool get isEditMode => _isEditMode;

  bool get isDeletingTicket => _isDeletingTicket;

  int get deletingIndex => _deletingIndex;

  bool get hasTicketFound => _hasTicketFound;

  Map<String, String> get departureAirport => _departureAirport;

  Map<String, String> get arrivalAirport => _arrivalAirport;

  List<Map<String, String>> get airports => _airports;

  String get nid => _nid;

  String get passport => _passport;

  set setTicketId(String ticketId) {
    _ticketId = ticketId;
  }

  set setTicketNotice(String ticketNotice) {
    _ticketNotice = ticketNotice;
  }

  set setStatus(int ticketStatus) {
    _ticketStatus = ticketStatus;
  }

  void toggleIsEditMode() {
    _isEditMode = !_isEditMode;
  }

  set setDepartureAirport(Map<String, String> departureAirport) {
    _departureAirport = departureAirport;
    notifyListeners();
  }

  set setIsDeletingTicket(bool value) {
    _isDeletingTicket = value;
    notifyListeners();
  }

  set setNid(String nid) {
    _nid = nid;
  }

  set setPassport(String passport) {
    _passport = passport;
  }

  set setSilentDepartureAirport(Map<String, String> departureAirport) {
    _departureAirport = departureAirport;
  }

  set setArrivalAirport(Map<String, String> arrivalAirport) {
    _arrivalAirport = arrivalAirport;
    notifyListeners();
  }

  set setSilentArrivalAirport(Map<String, String> arrivalAirport) {
    _arrivalAirport = arrivalAirport;
  }

  bool get isLoading => _isLoading;

  bool get isTicketListLoading => _isTicketListLoading;

  String get uITicketType => _uITicketType;

  set setIsTicketListLoading(bool isTicketListLoading) {
    _isTicketListLoading = isTicketListLoading;
    notifyListeners();
  }

  int get countOfTravellers => _countOfTravellers;

  void setCountOfTravellers(int countOfTravellers, {bool? shouldRefresh}) {
    _countOfTravellers = countOfTravellers;
    if (shouldRefresh == null) {
      notifyListeners();
    }
  }

  void setUiTicketType(String ticketType, {bool? shouldRefresh}) {
    _uITicketType = ticketType;
    if (shouldRefresh == null) {
      notifyListeners();
    }
  }

  set setTicketType(String ticketType) {
    Map<String, String> ticketTypes = {
      "ইকোনমি": "Economy Class",
      "বিজনেস": "Business Class",
      "প্রিমিয়াম": "Premium Class",
      "ফার্স্ট ক্লাস": "First Class"
    };
    _ticketType = ticketTypes[ticketType]!;
  }

  Future<void> datePicked(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (pickedDate != null) {
      ticketDate = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
    }
    notifyListeners();
  }

  set setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<bool> loadAirportList(String token) async {
    _finalResponse = false;
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
    notifyListeners();
    return _finalResponse;
  }

  Future<bool> deleteAirTicket(String token, int id, int index) async {
    _finalResponse = false;
    _deletingIndex = index;
    setIsDeletingTicket = true;
    response = await AirTicketService.deleteAirTicket(token, id.toString());
    if (response is Success) {
      ticketData.removeWhere((ticket) => ticket.id == id);
      if (ticketData.isEmpty) {
        _hasTicketFound = false;
      }
      _finalResponse = true;
    }
    _deletingIndex = -1;
    setIsDeletingTicket = false;
    return _finalResponse;
  }

  Future<bool> loadTicketList(String token) async {
    _finalResponse = false;
    DateTime parsedDate;
    String date;
    response = await AirTicketService.getTicketList(token);
    if (response is Success) {
      ticketData.clear();
      List<TicketData> tempTicketData = [];
      AirTicketModel airTicketModel = AirTicketModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      if (airTicketModel.ticketData != null) {
        for (TicketData ticket in airTicketModel.ticketData!) {
          parsedDate = DateTime.parse(ticket.travelDate.toString());
          date = DateFormat('yyyy-MM-dd').format(parsedDate);
          ticket.travelDate = date;
          parsedDate = DateTime.parse(ticket.createdAt.toString());
          date = DateFormat('MMMEd').format(parsedDate);
          ticket.createdAt = date;
          ticket.departureShort =
              getAirportShortName(ticket.from!.airportName.toString());
          ticket.arrivalShort =
              getAirportShortName(ticket.to!.airportName.toString());
          ticket.status = getTicketStatus(ticket.status.toString());
          ticket.price = (ticket.price) == null
              ? "Confirmation Pending"
              : "${ticket.price} BDT";
          tempTicketData.add(ticket);
        }
        ticketData = List.from(tempTicketData.reversed.toList());
      }
      _finalResponse = true;
    }
    if (ticketData.isEmpty) _hasTicketFound = false;
    setIsLoading = false;
    return _finalResponse;
  }

  String getAirportShortName(String airportName) {
    List<String> collection = airportName.split(" ");
    String shortForm = "";
    for (String string in collection) {
      shortForm = shortForm + string[0].toUpperCase();
    }
    return shortForm;
  }

  String getTicketStatus(String status) {
    Map<String, String> ticketStatus = {
      "0": "Submitted",
      "1": "In Review",
      "2": "Approved",
      "3": "Canceled",
    };
    return ticketStatus[status] ?? "Submitted";
  }

  int getTicketStatusInteger(String status) {
    Map<String, int> ticketStatus = {
      "Submitted": 0,
      "In Review": 1,
      "Approved": 2,
      "Canceled": 3,
    };
    return ticketStatus[status] ?? 0;
  }

  Future<bool> bookAirTicket(String token) async {
    setIsLoading = true;
    _finalResponse = false;
    Map<String, dynamic> ticketData = {
      "start": int.parse(_departureAirport['id'].toString()),
      "end": int.parse(_arrivalAirport['id'].toString()),
      "travel_date": ticketDate,
      "types": _ticketType,
      "person": _countOfTravellers,
      "status": _ticketStatus,
      "notice": _ticketNotice,
      "nid": _nid,
      "passport": _passport
    };
    if (!_isEditMode) {
      response = await AirTicketService.bookAirTicket(token, ticketData);
    } else {
      response =
          await AirTicketService.updateAirTicket(token, _ticketId, ticketData);
    }
    if (response is Success) {
      _finalResponse = true;
    }
    setIsLoading = false;
    return _finalResponse;
  }

  void resetData({bool? shouldUpdate}) {
    _departureAirport = {};
    _arrivalAirport = {};
    ticketDate = "";
    _ticketType = "First Class";
    _uITicketType = "ফার্স্ট ক্লাস";
    _countOfTravellers = 1;
    _passport = "";
    _nid = "";
    if (shouldUpdate != null) {
      notifyListeners();
    }
  }
}
