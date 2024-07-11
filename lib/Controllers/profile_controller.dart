import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  bool _isEdit = false;
  String _name = "FCLP";
  String _email = "mail@gmail.com";
  String _mobileNumber = "01888324567";
  String _token = "";

  bool get isEdit => _isEdit;

  String get name => _name;

  String get email => _email;

  String get mobileNumber => _mobileNumber;

  String get token => _token;

  void toggleEdit() {
    _isEdit = !_isEdit;
  }

  void setName(String newName) {
    _name = newName;
  }

  void setEmail(String newEmail) {
    _email = newEmail;
  }

  void setMobileNumber(String newMobileNumber) {
    _mobileNumber = newMobileNumber;
  }

  void setToken(String token){
    _token = token;
  }
}
