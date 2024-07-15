import 'package:fclp_app/models/product_model/product_model.dart';
import 'package:fclp_app/services/product_service.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:flutter/material.dart';

import '../models/product_model/product_data.dart';

class ProductController extends ChangeNotifier {
  List<ProductData> _productData = [];
  bool _finalResponse = false;
  bool _nextPageAvailable = false;
  bool _isLoading = false;
  Object? response;
  bool _willShowMoreProductDescription = false;
  double _selectedProductPrice = 0.0;
  int _selectedProductQuantity = 1;
  bool _isProductAddedToCart = false;

  double get selectedProductPrice => _selectedProductPrice;

  int get selectedProductQuantity => _selectedProductQuantity;

  bool get willShowMoreProductDescription => _willShowMoreProductDescription;

  List<ProductData> get productData => _productData;

  bool get nextPageAvailable => _nextPageAvailable;

  bool get isLoading => _isLoading;

  bool get isProductAddedToCart => _isProductAddedToCart;

  set setIsLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  void setProductPrice(double price) {
    _selectedProductPrice = price;
  }

  void increaseProductQuantity(double productUnitPrice) {
    _selectedProductQuantity++;
    _selectedProductPrice += productUnitPrice;
    notifyListeners();
  }

  void decreaseProductQuantity(double productUnitPrice) {
    if (_selectedProductQuantity != 1) {
      _selectedProductQuantity--;
      _selectedProductPrice -= productUnitPrice;
      notifyListeners();
    }
  }

  void resetSelectedProductData() {
    _selectedProductQuantity = 1;
    _isProductAddedToCart = false;
  }

  void toggleWillShowMoreProductDescription() {
    _willShowMoreProductDescription = !_willShowMoreProductDescription;
    notifyListeners();
  }

  String getDiscountPercentage(String discountPrice, String originalPrice) {
    double productDiscountPrice = double.parse(discountPrice);
    double productOriginalPrice = double.parse(originalPrice);
    double result =
        ((productOriginalPrice - productDiscountPrice) / productOriginalPrice) *
            100;
    String discountPercentage = result.toStringAsFixed(0);
    return discountPercentage;
  }

  Future<bool> addToCart(String token, ProductData product) async {
    _finalResponse = false;
    setIsLoading = true;
    Map<String, String> productData = {
      "product_id": product.id.toString(),
      "quantity": _selectedProductQuantity.toString(),
      "price": (product.discountPrice == "0")
          ? product.price.toString()
          : product.discountPrice.toString(),
    };
    response = await ProductService.addToCart(token, productData);
    if(response is Success){
      _finalResponse = true;
      _isProductAddedToCart = true;
    }
    setIsLoading = false;
    return _finalResponse;
  }

  Future<bool> loadProductData(int page, String token) async {
    _finalResponse = false;
    setIsLoading = true;
    response = await ProductService.getAllProductList(
        "page=${page.toString()}", token);
    if (response is Success) {
      ProductModel productModel = ProductModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      if (productModel.productData != null) {
        if (_productData.isEmpty) {
          _productData = await getProductData(productModel);
          _productData.shuffle();
        } else {
          List<ProductData> newProductData = await getProductData(productModel);
          newProductData.shuffle();
          _productData.addAll(newProductData);
        }
      }
      if (productModel.nextPageUrl != null) {
        _nextPageAvailable = true;
      } else {
        _nextPageAvailable = false;
      }
      _finalResponse = true;
    }
    setIsLoading = false;
    notifyListeners();
    return _finalResponse;
  }

  Future<List<ProductData>> getProductData(ProductModel productModel) async {
    List<ProductData> product = [];
    for (ProductData productData in productModel.productData!) {
      if (productData.quantity != "0") {
        product.add(productData);
      }
    }
    return product.toList();
  }
}
