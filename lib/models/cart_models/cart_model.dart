import 'cart_data.dart';

class CartModel{
  int? totalItems;
  CartData? cart;

  CartModel({this.totalItems, this.cart});

  CartModel.fromJson(Map<String, dynamic> json) {
    totalItems = json['total_items'];
    cart = json['cart'] != null ? new CartData.fromJson(json['cart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_items'] = this.totalItems;
    if (this.cart != null) {
      data['cart'] = this.cart!.toJson();
    }
    return data;
  }
}