import 'notification.dart';

class NotificationModel {
  int? totalNotification;
  List<Notification>? notification;

  NotificationModel({this.totalNotification, this.notification});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    totalNotification = json['total_notification'];
    if (json['notification'] != null) {
      notification = <Notification>[];
      json['notification'].forEach((v) {
        notification!.add(Notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_notification'] = totalNotification;
    if (notification != null) {
      data['notification'] = notification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}