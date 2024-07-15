import 'carts.dart';

class CartModel{
  String? message;
  int? totalCarts;
  List<Carts>? carts;

  CartModel({this.message, this.totalCarts, this.carts});

  CartModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalCarts = json['total carts'];
    if (json['carts'] != null) {
      carts = <Carts>[];
      json['carts'].forEach((v) {
        carts!.add(Carts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['total carts'] = totalCarts;
    if (carts != null) {
      data['carts'] = carts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}