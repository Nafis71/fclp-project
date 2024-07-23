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
  bool isProductAddedToCart = false;

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
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['discount_price'] = discountPrice;
    data['image'] = image;
    data['category_id'] = categoryId;
    data['description'] = description;
    data['quantity'] = quantity;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (colors != null) {
      data['colors'] = colors!.map((v) => v.toJson()).toList();
    }
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}