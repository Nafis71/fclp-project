import 'dart:convert';
import 'dart:io';

import 'package:fclp_app/models/redeem_list_model/redeem_list.dart';
import 'package:fclp_app/models/redeem_list_model/redeem_list_model.dart';
import 'package:fclp_app/models/referral_model/referral_model.dart';
import 'package:fclp_app/models/user_model/user.dart';
import 'package:fclp_app/models/user_model/user_model.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:fclp_app/services/user_profile_service.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends ChangeNotifier {
  bool _isEdit = false;
  String _token = "";
  String _base64Image = "";
  late User userData;
  Object? response;
  final ImagePicker _imagePicker = ImagePicker();
  bool _isLoading = false;
  bool isLoadingReferral = false;
  List<ReferralModel> referralList = [];
  List<RedeemList> redeemList = [];

  bool get isLoading => _isLoading;
  bool _finalResponse = false;
  String _total_redeem = "0";
  String _total_amount = "0";
  bool _isTransactionHistoryLoading = false;

  set setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isTransactionHistoryLoading => _isTransactionHistoryLoading;

  String get total_redeem => _total_redeem;

  String get total_amount => _total_amount;

  String get base64Image => _base64Image;

  bool get isEdit => _isEdit;

  String get token => _token;

  void toggleEdit() {
    _isEdit = !_isEdit;
    notifyListeners();
  }

  void setResetBase64Image() {
    _base64Image = "";
    _isEdit = false;
  }

  void setToken(String token) {
    _token = token;
  }

  Future<void> pickImage() async {
    XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      convertImage(pickedFile);
    }
  }

  void convertImage(XFile pickedFile) {
    List<int> imageBytes = File(pickedFile.path).readAsBytesSync();
    _base64Image = base64Encode(imageBytes);
    notifyListeners();
  }

  Future<bool> updateProfile(
      {required String email,
      required String mobile,
      required String name}) async {
    _finalResponse = false;
    setIsLoading = true;
    if (base64Image.isNotEmpty) {
      userData.base64Image = base64Image;
    }
    await saveUserData(name, mobile, email);
    response = await UserProfileService.updateProfile(
        _token, userData.id.toString(), userData);
    if (response is Success) {
      setIsLoading = false;
      _finalResponse = true;
    }
    setIsLoading = false;
    return _finalResponse;
  }

  Future<bool> activateProfile(
      String mobile, String transactionId, String paymentMethod) async {
    _finalResponse = false;
    setIsLoading = true;
    Map<String, String> transactionDetails = {
      "mobile": mobile,
      "trx_id": transactionId,
      "payment_method": paymentMethod
    };
    response = await UserProfileService.accountActiveRequest(
        token, transactionDetails);
    if (response is Success) {
      setIsLoading = false;
      _finalResponse = true;
    }
    setIsLoading = false;
    return _finalResponse;
  }

  Future<bool> checkProfileActiveStatus() async {
    _finalResponse = false;
    setIsLoading = true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    response = await UserProfileService.checkActivationStatus(token);
    if (response is Success) {
      UserModel userModel = UserModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      if (userModel.user != null) {
        for (User user in userModel.user!) {
          if (user.id == userData.id && user.status == "1") {
            userData.status = "1";
            preferences.setString("userData", jsonEncode(userData.toJson()));
            _finalResponse = true;
          }
          if (user.id == userData.id && user.status == "2") {
            userData.status = "2";
            preferences.setString("userData", jsonEncode(userData.toJson()));
            _finalResponse = false;
          }
        }
      }
    }
    setIsLoading = false;
    return _finalResponse;
  }

  Future<void> loadReferrals() async {
    isLoadingReferral = true;
    response = await UserProfileService.getReferrals(token);
    if (response is Success) {
      referralList.clear();
      List<dynamic> jsonData = (response as Success).response as List<dynamic>;
      for (Map<String, dynamic> json in jsonData) {
        referralList.add(ReferralModel.fromJson(json));
      }
    }
    isLoadingReferral = false;
    notifyListeners();
  }

  Future<void> getUserReferralPoint({required bool forceRefresh}) async {
    if (redeemList.isNotEmpty && !forceRefresh) {
      return;
    }
    response = await UserProfileService.getAllUser(token);
    if (response is Success) {
      Map<String, dynamic> jsonData =
          (response as Success).response as Map<String, dynamic>;
      for (Map<String, dynamic> json in jsonData['user']) {
        if (json['id'] == userData.id) {
          userData.points = json['points'];
        }
      }
      notifyListeners();
    }
  }

  Future<bool> redeemPoint(
      int points, String paymentMethod, String mobile) async {
    _finalResponse = false;
    setIsLoading = true;
    Map<String, dynamic> redeemData = {
      "point": points,
      "payment_method": paymentMethod,
      "mobile": mobile
    };
    response = await UserProfileService.redeemPoint(token, redeemData);
    if (response is Success) {
      userData.points = (int.parse(userData.points) - points).toString();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("userData", json.encode(userData.toJson()));
      _finalResponse = true;
    }
    await getRedeemTransactionList(forceRefresh: true);
    setIsLoading = false;
    return _finalResponse;
  }

  Future<void> getRedeemTransactionList({required bool forceRefresh}) async {
    if (redeemList.isNotEmpty && !forceRefresh) {
      return;
    }
    _isTransactionHistoryLoading = true;
    redeemList.clear();
    try {
      response = await UserProfileService.redeemPointList(token);
      if (response is Success) {
        RedeemListModel redeemListModel = RedeemListModel.fromJson(
            (response as Success).response as Map<String, dynamic>);
        _total_amount = redeemListModel.totalAmount ?? "0";
        _total_redeem = redeemListModel.totalRedeem ?? "0";
        List<RedeemList> tempList = [];
        for (RedeemList redeem in redeemListModel.redeemList!) {
          tempList.add(redeem);
        }
        redeemList = tempList.reversed.toList();
      }
      _isTransactionHistoryLoading = false;
      notifyListeners();
    } catch (exception) {
      if (kDebugMode) {
        debugPrint(exception.toString());
      }
    }
  }

  Future<void> saveUserData(String name, String mobile, String email) async {
    userData.name = name;
    userData.mobile = mobile;
    userData.email = email;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("userData", jsonEncode(userData.toJson()));
  }
}
