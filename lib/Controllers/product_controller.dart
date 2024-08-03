import 'package:fclp_app/Controllers/cart_controller.dart';
import 'package:fclp_app/models/cart_models/cart_product.dart';
import 'package:fclp_app/models/product_model/product_model.dart';
import 'package:fclp_app/services/product_service.dart';
import 'package:fclp_app/services/response/success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/product_model/product_data.dart';

class ProductController extends ChangeNotifier {
  List<ProductData> _productData = [];
  List<ProductData> _specificProductData = [];
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

  set setIsCategorialProductFetching(bool value) {
    _isCategorialProductFetching = value;
  }

  set setIsStoringCartList(bool value) {
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

  Future<bool> addToCart(
      String token, ProductData product, CartController cartController) async {
    _finalResponse = false;
    setIsStoringCartList = true;
    int quantity = selectedProductQuantity;
    bool hasFoundInCart = false;
    if (cartController.cartList.isNotEmpty) {
      for (CartProduct cartData in cartController.cartList) {
        if (cartData.name == product.name.toString()) {
          quantity += int.parse(cartData.quantity.toString());
          cartData.quantity = quantity.toString();
          hasFoundInCart = true;
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
      Map<String, dynamic> responseJson =
          (response as Success).response as Map<String, dynamic>;
      if (!hasFoundInCart) {
        CartProduct cartProduct = CartProduct(
            productId: product.id,
            itemId: responseJson['cartItem']['id'],
            name: product.name,
            image: product.image,
            quantity: quantity.toString(),
            price: (product.discountPrice == "0")
                ? product.price.toString()
                : product.discountPrice.toString());
        cartController.insertAtCart(0, cartProduct);
      } else {
        for (int i = 0; i < cartController.cartList.length; i++) {
          if (cartController.cartList[i].itemId ==
              responseJson['cartItem']['id']) {
            cartController.updateQuantity(i, quantity.toString());
            break;
          }
        }
      }
      cartController.calculateTotalCartPrice();
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

  Future<void> loadSpecificProductData(
      String categoryId, String token, int page, int currentProductId) async {
    setIsCategorialProductFetching = true;
    response = await ProductService.getAllProductList(
        "page=${page.toString()}", token);
    if (response is Success) {
      ProductModel productModel = ProductModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      if (productModel.productData != null) {
        if (_specificProductData.isEmpty) {
          _specificProductData = await getProductData(productModel,
              categoryId: categoryId, currentProductId: currentProductId);
          _specificProductData.shuffle();
        } else {
          List<ProductData> newProductData = await getProductData(productModel,
              categoryId: categoryId, currentProductId: currentProductId);
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

  Future<List<ProductData>> getProductData(ProductModel productModel,
      {String? categoryId, int? currentProductId}) async {
    List<ProductData> product = [];
    for (ProductData productData in productModel.productData!) {
      if (productData.quantity != "0") {
        if (categoryId != null && productData.categoryId == categoryId) {
          if (productData.id != currentProductId) {
            product.add(productData);
          }
          continue;
        }
        product.add(productData);
      }
    }
    return product.toList();
  }

  void productAddedFromCard() {
    _isProductAddedToCart = false;
    notifyListeners();
  }
}
