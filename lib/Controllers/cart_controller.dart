import 'package:fclp_app/models/cart_models/cart_product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/cart_models/cart_model.dart';
import '../models/cart_models/cart_data.dart';
import '../services/product_service.dart';
import '../services/response/success.dart';

class CartController extends ChangeNotifier {
  List<CartProduct> _cartList = [];
  bool _finalResponse = false;
  int _selectedProductIndex = -1;
  int totalCartPrice = 0;
  Object? response;

  List<CartProduct> get cartList => _cartList;

  void insertAtCart(int index, CartProduct element){
    _cartList.insert(index, element);
    notifyListeners();
  }

  void updateQuantity(int index, String quantity){
    _cartList[index].quantity = quantity;
    notifyListeners();
  }

  int get selectedProductIndex => _selectedProductIndex;

  Future<void> loadCartData(String token) async {
    response = await ProductService.getCartData(token);
    if (response is Success) {
      CartModel cartModel = CartModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      if (cartModel.cart?.products != null) {
        for (CartProduct cart in cartModel.cart!.products!) {
          totalCartPrice += getProductTotalPrice(
                  cart.quantity.toString(), cart.price.toString())
              .toInt();
          cartList.add(cart);
        }
      }
    }
    notifyListeners();
  }

  Future<bool> deleteFromCart(String token, int productId, int index) async {
    _finalResponse = false;
    _selectedProductIndex = index;
    notifyListeners();
    response = await ProductService.deleteCartItem(token, productId.toString());
    if (response is Success) {
      _finalResponse = true;
      _cartList.removeWhere((product) => product.itemId == productId);
      calculateTotalCartPrice();
      _selectedProductIndex = -1;
      return _finalResponse;
    }
    _selectedProductIndex = -1;
    notifyListeners();
    return _finalResponse;
  }

  void calculateTotalCartPrice(){
    int totalPrice = 0;
    for(CartProduct cartProduct in _cartList){
      totalPrice += getProductTotalPrice(
          cartProduct.quantity.toString(), cartProduct.price.toString())
          .toInt();
    }
    totalCartPrice = totalPrice;
    notifyListeners();
  }

  double getProductTotalPrice(String quantity, String unitPrice) {
    int productQuantity = int.parse(quantity);
    double productUnitPrice = double.parse(unitPrice);
    return productUnitPrice * productQuantity;
  }
}
