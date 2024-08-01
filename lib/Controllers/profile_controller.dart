import 'dart:convert';
import 'dart:io';
import 'package:fclp_app/models/referral_model/referral_model.dart';
import 'package:fclp_app/models/user_model/user.dart';
import 'package:fclp_app/models/user_model/user_model.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:fclp_app/services/user_profile_service.dart';
import 'package:flutter/material.dart';
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
  bool get isLoading => _isLoading;

  set setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

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

  Future<bool> updateProfile({required String email,
    required String mobile,
    required String name}) async {
    setIsLoading = true;
    if(base64Image.isNotEmpty){
      userData.base64Image = base64Image;
    }
    await saveUserData(name,mobile,email);
    response = await UserProfileService.updateProfile(_token, userData.id.toString(), userData);
    if(response is Success){
      setIsLoading = false;
      return true;
    }
    setIsLoading = false;
    return false;
  }

  Future<bool> activateProfile(String mobile, String transactionId, String paymentMethod) async{
    setIsLoading = true;
    Map<String,String> transactionDetails ={
      "mobile":mobile,
      "trx_id":transactionId,
      "payment_method":paymentMethod
    };
    response =  await UserProfileService.accountActiveRequest(token, transactionDetails);
    if(response is Success){
      setIsLoading = false;
      return true;
    }
    setIsLoading = false;
    return false;
  }

  Future<bool> checkProfileActiveStatus() async{
    setIsLoading = true;
    SharedPreferences preferences =  await SharedPreferences.getInstance();
    response = await UserProfileService.checkActivationStatus(token);
    if(response is Success){
      UserModel userModel = UserModel.fromJson((response as Success).response as Map<String,dynamic>);
      if(userModel.user != null){
        for(User user in userModel.user!){
          if(user.id == userData.id && user.status == "1"){
            userData.status = "1";
            preferences.setString("userData", jsonEncode(userData.toJson()));
            setIsLoading = false;
            return true;
          }
          if(user.id == userData.id && user.status == "2"){
            userData.status = "2";
            preferences.setString("userData", jsonEncode(userData.toJson()));
            setIsLoading = false;
            return false;
          }
        }
      }
    }
    setIsLoading = false;
    return false;
  }
  
  Future<void> loadReferrals() async{
    isLoadingReferral = true;
    response = await UserProfileService.getReferrals(token);
    if(response is Success){
      referralList.clear();
      List<dynamic> jsonData = (response as Success).response as List<dynamic>;
      for(Map<String,dynamic> json in jsonData){
        referralList.add(ReferralModel.fromJson(json));
      }
    }
    isLoadingReferral = false;
    notifyListeners();
  }

  Future<void> saveUserData(String name, String mobile,String email) async{
   userData.name = name;
   userData.mobile = mobile;
   userData.email = email;
   SharedPreferences preferences = await SharedPreferences.getInstance();
   preferences.setString("userData", jsonEncode(userData.toJson()));
  }
}
