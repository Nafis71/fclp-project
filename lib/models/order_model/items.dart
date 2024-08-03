import 'package:fclp_app/models/order_model/products.dart';

class Items {
  int? id;
  String? orderId;
  String? productId;
  String? quantity;
  String? price;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Items(
      {this.id,
      this.orderId,
      this.productId,
      this.quantity,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.product});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}
