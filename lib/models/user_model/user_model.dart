import 'package:fclp_app/models/user_model/user.dart';

class UserModel {
  String? message;
  List<User>? user;

  UserModel({this.message, this.user});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
