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
  int _currentSelectedOrderId = 0;
  Object? response;
  Map<String, String> _deliveryDetails = {
    "address": "",
    "city": "",
    "cost": "",
    "order_id": ""
  };

  bool get isInsideDhaka => _isInsideDhaka;

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
  }
}
