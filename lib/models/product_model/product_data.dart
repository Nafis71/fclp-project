import 'package:fclp_app/models/product_model/product_category.dart';
import 'package:fclp_app/models/product_model/product_colors.dart';
import 'package:fclp_app/models/product_model/product_size.dart';

class ProductData{
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
  List<ProductColors>? colors;
  List<ProductSize>? sizes;
  ProductCategory? category;

  ProductData(
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
        this.updatedAt,
        this.colors,
        this.sizes,this.category});

  ProductData.fromJson(Map<String, dynamic> json) {
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
    if (json['colors'] != null) {
      colors = <ProductColors>[];
      json['colors'].forEach((v) {
        colors!.add(new ProductColors.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = <ProductSize>[];
      json['sizes'].forEach((v) {
        sizes!.add(ProductSize.fromJson(v));
      });
    }
    category = json['category'] != null
        ? new ProductCategory.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}