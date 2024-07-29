class Product {
  int? id;
  String? name;
  String? price;
  String? discountPrice;
  String? image;
  String? categoryId;
  String? description;
  String? quantity;
  String? status;
  String? createdAt;
  String? updatedAt;

  Product(
      {this.id,
        this.name,
        this.price,
        this.discountPrice,
        this.image,
        this.categoryId,
        this.description,
        this.quantity,
        this.status,
        this.createdAt,
        this.updatedAt});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    discountPrice = json['discount_price'];
    image = json['image'];
    categoryId = json['category_id'];
    description = json['description'];
    quantity = json['quantity'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['discount_price'] = this.discountPrice;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}