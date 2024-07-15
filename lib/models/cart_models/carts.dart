class CartData {
  int? id;
  String? userId;
  String? productId;
  String? quantity;
  String? price;
  String? createdAt;
  String? updatedAt;

  CartData({this.id,
    this.userId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt});

  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}