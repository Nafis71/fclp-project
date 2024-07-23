import 'package:fclp_app/models/cart_models/cart_product.dart';
import 'package:flutter/foundation.dart';

import '../models/cart_models/cart_model.dart';
import '../models/cart_models/cart_data.dart';
import '../services/product_service.dart';
import '../services/response/success.dart';

class CartController extends ChangeNotifier{
  List<CartProduct> _cartList =[];
  Object? response;

  List<CartProduct> get cartList => _cartList;


  Future<void> loadCartData(String token) async {
    response = await ProductService.getCartData(token);
    if (response is Success) {
      CartModel cartModel = CartModel.fromJson(
          (response as Success).response as Map<String, dynamic>);
      if(cartModel.cart?.products != null){
        for(CartProduct cart in cartModel.cart!.products!){
          cartList.add(cart);
        }
      }
    }
    notifyListeners();
  }
}