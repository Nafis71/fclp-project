import 'package:fclp_app/models/cart_models/cart_model.dart';
import 'package:fclp_app/models/cart_models/carts.dart';
import 'package:fclp_app/models/product_model/product_model.dart';
import 'package:fclp_app/services/product_service.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product_model/product_data.dart';

class ProductController extends ChangeNotifier {
  List<ProductData> _productData = [];
  List<ProductData> _specificProductData =[];
  List<CartData> cartList =[];
  bool _finalResponse = false;
  bool _isCategorialProductFetching = false;
  bool _nextPageAvailable = false;
  bool _categorialNextPageAvailable = true;
  bool _isLoading = true;
  bool _isStoringCartList = false;
  Object? response;
  bool _willShowMoreProductDescription = false;
  double _selectedProductPrice = 0.0;
  int _selectedProductQuantity = 1;
  bool _isProductAddedToCart = false;

  bool get categorialNextPageAvailable => _categorialNextPageAvailable;

  bool get isCategorialProductFetching => _isCategorialProductFetching;

  double get selectedProductPrice => _selectedProductPrice;

  List<ProductData> get specificProductData => _specificProductData;

  int get selectedProductQuantity => _selectedProductQuantity;

  bool get willShowMoreProductDescription => _willShowMoreProductDescription;

  List<ProductData> get productData => _productData;

  bool get nextPageAvailable => _nextPageAvailable;

  bool get isLoading => _isLoading;

  bool get isProductAddedToCart => _isProductAddedToCart;

  bool get isStoringCartList => _isStoringCartList;

  set setIsLoading(bool isLoading) {
    _isLoading = isLoading;
  }
  set setIsCategorialProductFetching (bool value){
    _isCategorialProductFetching = value;
  }
  set setIsStoringCartList(bool value){
    _isStoringCartList = value;
    notifyListeners();
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
    setIsStoringCartList = true;
    int quantity = selectedProductQuantity;
    if(cartList.isNotEmpty){
      for(CartData cartData in cartList){
        if(cartData.productId == product.id.toString()){
          quantity += int.parse(cartData.quantity.toString());
          cartData.quantity = quantity.toString();
          break;
        }
      }
    }
    Map<String, String> productData = {
      "product_id": product.id.toString(),
      "quantity": quantity.toString(),
      "price": (product.discountPrice == "0")
          ? product.price.toString()
          : product.discountPrice.toString(),
    };
    response = await ProductService.addToCart(token, productData);
    if (response is Success) {
      _finalResponse = true;
      _isProductAddedToCart = true;
    }
    setIsStoringCartList = false;
    return _finalResponse;
  }

  Future<void> loadProductData(int page, String token) async {
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

    }
    setIsLoading = false;
    notifyListeners();
  }

  Future<void> loadSpecificProductData(String categoryId,String token,int page,int currentProductId) async{
    setIsCategorialProductFetching = true;
    print("getting product Id : $currentProductId");
    response =  await ProductService.getAllProductList("page=${page.toString()}", token);
    if(response is Success){
      ProductModel productModel = ProductModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      if (productModel.productData != null) {
        if (_specificProductData.isEmpty) {
          print("Accessing First");
          _specificProductData = await getProductData(productModel,categoryId: categoryId,currentProductId: currentProductId);
          _specificProductData.shuffle();
        } else {
          print("Accessing Second");
          List<ProductData> newProductData = await getProductData(productModel,categoryId: categoryId,currentProductId: currentProductId);
          newProductData.shuffle();
          _specificProductData.addAll(newProductData);
        }
      }
      if (productModel.nextPageUrl != null) {
        _categorialNextPageAvailable = true;
      } else {
        _categorialNextPageAvailable = false;
      }
    }
    setIsCategorialProductFetching = false;
    notifyListeners();
  }


  Future<void> loadCartData(String token) async {
    setIsLoading = true;
    response = await ProductService.getCartData(token);
    if (response is Success) {
      CartModel cartModel = CartModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      if(cartModel.cartData != null){
        for(CartData cart in cartModel.cartData!){
          cartList.add(cart);
        }
        setIsLoading = false;
      }
    }
    setIsLoading = false;
    notifyListeners();
  }

  Future<List<ProductData>> getProductData(ProductModel productModel,{String? categoryId,int? currentProductId}) async {
    List<ProductData> product = [];
    for (ProductData productData in productModel.productData!) {
      if (productData.quantity != "0") {
        if(categoryId != null && productData.categoryId == categoryId){
          print("Current : $currentProductId");
          if(productData.id != currentProductId){
            print(productData.id);
            product.add(productData);
          }
          continue;
        }
        product.add(productData);
      }
    }
    return product.toList();
  }
}
