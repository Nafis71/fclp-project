import 'package:fclp_app/services/order_service.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../models/order_model/order_model.dart';

class OrderController extends ChangeNotifier {
  List<OrderModel> _orderList = [];
  bool _finalResponse = false;
  bool _isInsideDhaka = true;
  bool _isInsideDhakaPressed = true;
  bool _isOutsideDhakaPressed = false;
  bool _isBkashSelected = true;
  bool _isBkashPressed = true;
  bool _isNagadPressed = false;
  int _currentSelectedOrderId = 0;
  int activeStep = 0;
  bool _isBusy = false;
  Object? response;
  final Map<String, String> _deliveryDetails = {
    "address": "",
    "city": "",
    "cost": "",
    "order_id": ""
  };
  final Map<String, dynamic> _paymentDetails = {
    "delivery_cost_id": 0,
    "payment_method":"", // bkash,nagad
    "trx_id":"",
    "phone":""
  };

  bool get isInsideDhaka => _isInsideDhaka;
  bool get isBusy => _isBusy;
  bool get isBkashSelected => _isBkashSelected;
  bool get isBkashPressed => _isBkashPressed;
  bool get isNagadPressed => _isNagadPressed;

  set setIsBkashSelected(bool value){
    _isBkashSelected = value;
    notifyListeners();
  }

  set setIsBusy(bool value){
    _isBusy = value;
    notifyListeners();
  }

  set setIsBkashPressed(bool value){
    _isBkashPressed = value;
  }
  set setIsNagadPressed(bool value){
    _isNagadPressed = value;
  }

  set setCurrentSelectedOrderId(int value) {
    _currentSelectedOrderId = value;
  }

  bool get isInsideDhakaPressed => _isInsideDhakaPressed;

  bool get isOutsideDhakaPressed => _isOutsideDhakaPressed;

  List<OrderModel> get orderList => _orderList;

  set setIsInsideDhaka(bool value) {
    _isInsideDhaka = value;
    notifyListeners();
  }

  set setIsInsideDhakaPressed(bool value) {
    _isInsideDhakaPressed = value;
  }

  set setOutsideDhakaPressed(bool value) {
    _isOutsideDhakaPressed = value;
  }

  Future<void> loadOrderList(String token) async {
    response = await OrderService.getOrderList(token);
    if (response is Success) {
      List<dynamic> jsonData = (response as Success).response as List<dynamic>;
      List<OrderModel> tempOrderList = [];
      for (Map<String, dynamic> json in jsonData) {
        OrderModel orderModel = OrderModel.fromJson(json);
        DateTime date = DateTime.parse(orderModel.createdAt.toString());
        orderModel.createdAt = DateFormat('dd-MM-yyyy').format(date);
        tempOrderList.add(orderModel);
        _orderList = tempOrderList.reversed.toList();
      }
    }
    notifyListeners();
  }


  void recordDeliveryDetails(String address, String cityName) {
    _deliveryDetails['address'] = address;
    _deliveryDetails['city'] = (_isInsideDhaka) ? "Dhaka" : cityName;
    _deliveryDetails['cost'] = (_isInsideDhaka) ? "80" : "120";
    _deliveryDetails['order_id'] = _currentSelectedOrderId.toString();
    activeStep++;
    notifyListeners();
  }

  Future<bool> storePaymentInfo(String token,String transId,String phone) async{
    _finalResponse = false;
    setIsBusy = true;
    _paymentDetails['payment_method'] = (_isBkashSelected) ? "bkash" : "nagad";
    _paymentDetails['trx_id'] = transId.trim();
    _paymentDetails['phone'] = phone.trim();
    response = await OrderService.storeDeliveryInfo(token, _deliveryDetails);
    if(response is Success){
      Map<String,dynamic> jsonData = (response as Success).response as Map<String,dynamic>;
      _paymentDetails['delivery_cost_id'] = jsonData['delivery_cost_id'];
      response = await OrderService.storeDeliveryPaymentInfo(token, _paymentDetails);
      if(response is Success){
        _finalResponse = true;
        activeStep++;
      }
    }
    setIsBusy = false;
    return _finalResponse;
  }

  Future<void> cancelOrder(String token, int orderId) async{
    _orderList.removeWhere((order)=> order.id == orderId);
    notifyListeners();
    response = await OrderService.cancelOrder(token, orderId.toString());
  }

  void resetOrderController(){
    _deliveryDetails.clear();
    _paymentDetails.clear();
    _isInsideDhaka = true;
    _isBkashSelected =  true;
    _isBkashPressed = true;
    _isInsideDhakaPressed = true;
    _isOutsideDhakaPressed = false;
    _isNagadPressed = false;
    activeStep = 0;
  }

}
