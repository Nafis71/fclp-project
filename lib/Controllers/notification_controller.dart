import 'package:fclp_app/models/notification_models/notification_model.dart';
import 'package:fclp_app/services/notification_service.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../models/notification_models/notification.dart';

class NotificationController extends ChangeNotifier{
  String _totalNotification = "";
  List<Notification> _notificationList = [];
  bool _isNotificationSeen = false;

  bool get isNotificationSeen => _isNotificationSeen;

  set setIsNotificationSeen(bool value){
    _isNotificationSeen = value;
    notifyListeners();
  }

  String get totalNotification =>_totalNotification;
  List<Notification> get notificationList => _notificationList;

  Future<void> getAllNotification(String token) async{
    Object? response = await NotificationService.getAllNotification(token);
    if(response is Success){
      NotificationModel notificationModel = NotificationModel.fromJson((response as Success).response as Map<String,dynamic>);
      List<Notification> tempNotificationList =[];
      for(Notification notification in notificationModel.notification!){
        DateTime dateTime = DateTime.parse(notification.createdAt.toString());
        notification.createdAt = DateFormat('MMMEd').format(dateTime);
        tempNotificationList.add(notification);
      }
      _notificationList = tempNotificationList.reversed.toList();
      _totalNotification = notificationModel.totalNotification.toString();
      notifyListeners();
    }
  }

}