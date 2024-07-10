class ProductModel {
  final int id;
  final String title;
  final String img;
  final double originalPrice;
  final double discountPrice;
  final String description;
  bool isFavorite;
  int count;
  bool isShopping;

  ProductModel({
    required this.id,
    required this.title,
    required this.img,
    required this.originalPrice,
    required this.discountPrice,
    required this.description,
    this.isFavorite = false,
    this.count = 1,
    this.isShopping = false,
  });
}
