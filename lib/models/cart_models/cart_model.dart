import 'carts.dart';

class CartModel{
  String? message;
  int? totalCarts;
  List<CartData>? cartData;

  CartModel({this.message, this.totalCarts, this.cartData});

  CartModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    totalCarts = json['total carts'];
    if (json['carts'] != null) {
      cartData = <CartData>[];
      json['carts'].forEach((v) {
        cartData!.add(CartData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['total carts'] = totalCarts;
    if (cartData != null) {
      data['carts'] = cartData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}