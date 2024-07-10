import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  bool _isEdit = false;
  String _name = "FCLP";
  String _email = "mail@gmail.com";
  String _mobileNumber = "01888324567";

  bool get isEdit => _isEdit;

  String get name => _name;

  String get email => _email;

  String get mobileNumber => _mobileNumber;

  void toggleEdit() {
    _isEdit = !_isEdit;
    notifyListeners();
  }

  void setName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void setEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }

  void setMobileNumber(String newMobileNumber) {
    _mobileNumber = newMobileNumber;
    notifyListeners();
  }
}
