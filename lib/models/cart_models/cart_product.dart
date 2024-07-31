class CartProduct{
  int? itemId;
  String? name;
  String? image;
  String? quantity;
  String? price;
  int? productId;

  CartProduct({this.productId, this.itemId, this.name, this.image, this.quantity, this.price});

  CartProduct.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'];
    name = json['name'];
    image = json['image'];
    quantity = json['quantity'];
    price = json['price'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_id'] = this.itemId;
    data['name'] = this.name;
    data['image'] = this.image;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    return data;
  }
}