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

  List<ProductData> get productData => _productData;

  bool get nextPageAvailable => _nextPageAvailable;

  bool get isLoading => _isLoading;

  set setIsLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  String getDiscountPercentage(String discountPrice, String originalPrice) {
    double productDiscountPrice = double.parse(discountPrice);
    double productOriginalPrice = double.parse(originalPrice);
    double result = ((productOriginalPrice - productDiscountPrice)/productOriginalPrice) * 100;
    String discountPercentage = result.toStringAsFixed(0);
    return discountPercentage;
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

  Future<List<ProductData>> getProductData(ProductModel productModel) async{
    List<ProductData> product =[];
    for(ProductData productData in productModel.productData!){
      if(productData.quantity != "0"){
        product.add(productData);
      }
    }
    return product.toList();
  }
}
