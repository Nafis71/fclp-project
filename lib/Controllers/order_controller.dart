import 'package:fclp_app/services/order_service.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../models/order_model/order_model.dart';

class OrderController extends ChangeNotifier{
  List<OrderModel> _orderList =[];
  bool _finalResponse = false;
  Object? response;


  List<OrderModel> get orderList => _orderList;

  Future<void> loadOrderList(String token) async{
    response = await OrderService.getOrderList(token);
    if(response is Success){
      List<dynamic> jsonData = (response as Success).response as List<dynamic>;
      List<OrderModel> _tempOrderList = [];
      for(Map<String,dynamic> json in jsonData){
        OrderModel orderModel = OrderModel.fromJson(json);
        DateTime date = DateTime.parse(orderModel.createdAt.toString());
        orderModel.createdAt = DateFormat('dd-MM-yyyy').format(date);
        _tempOrderList.add(orderModel);
        _orderList = _tempOrderList.reversed.toList();
      }
    }
    notifyListeners();
  }

}