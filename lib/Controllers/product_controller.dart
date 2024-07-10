import 'package:fclp_app/models/entities/product_model.dart';
import 'package:flutter/material.dart';

class ProductController extends ChangeNotifier {
  final List<ProductModel> _productData = [
    ProductModel(
      id: 1,
      title: "Football N5",
      img:
          'https://w0.peakpx.com/wallpaper/542/929/HD-wallpaper-football-soccer-fire-ball-soccer-sports-football.jpg',
      originalPrice: 200,
      discountPrice: 50,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      isFavorite: false,
      count: 1,
      isShopping: false,
    ),
    ProductModel(
      id: 2,
      title: "Sony Max",
      img:
          'https://w0.peakpx.com/wallpaper/542/929/HD-wallpaper-football-soccer-fire-ball-soccer-sports-football.jpg',
      originalPrice: 200,
      discountPrice: 30,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      isFavorite: false,
      count: 1,
      isShopping: false,
    ),
    ProductModel(
      id: 3,
      title: "Nokia Xpro",
      img:
          'https://w0.peakpx.com/wallpaper/542/929/HD-wallpaper-football-soccer-fire-ball-soccer-sports-football.jpg',
      originalPrice: 200,
      discountPrice: 60,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      isFavorite: false,
      count: 1,
      isShopping: false,
    ),
    ProductModel(
      id: 4,
      title: "Tecno 98",
      img:
          'https://w0.peakpx.com/wallpaper/542/929/HD-wallpaper-football-soccer-fire-ball-soccer-sports-football.jpg',
      originalPrice: 200,
      discountPrice: 70,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      isFavorite: false,
      count: 1,
      isShopping: false,
    ),
    ProductModel(
      id: 5,
      title: "iPhone 15 pro max",
      img:
          'https://w0.peakpx.com/wallpaper/542/929/HD-wallpaper-football-soccer-fire-ball-soccer-sports-football.jpg',
      originalPrice: 200,
      discountPrice: 25,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      isFavorite: false,
      count: 1,
      isShopping: false,
    ),
    ProductModel(
      id: 6,
      title: "Samsung Galaxy S23 Ultra pro max",
      img:
          'https://w0.peakpx.com/wallpaper/542/929/HD-wallpaper-football-soccer-fire-ball-soccer-sports-football.jpg',
      originalPrice: 200,
      discountPrice: 13,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      isFavorite: false,
      count: 1,
      isShopping: false,
    ),
    ProductModel(
      id: 7,
      title: "FastKey Keyboard",
      img:
          'https://w0.peakpx.com/wallpaper/542/929/HD-wallpaper-football-soccer-fire-ball-soccer-sports-football.jpg',
      originalPrice: 200,
      discountPrice: 50,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      isFavorite: false,
      count: 1,
      isShopping: false,
    ),
    ProductModel(
      id: 8,
      title: "Mouse 23",
      img:
          'https://w0.peakpx.com/wallpaper/542/929/HD-wallpaper-football-soccer-fire-ball-soccer-sports-football.jpg',
      originalPrice: 200,
      discountPrice: 50,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      isFavorite: false,
      count: 1,
      isShopping: false,
    ),
    ProductModel(
      id: 9,
      title: "Matador",
      img:
          'https://w0.peakpx.com/wallpaper/542/929/HD-wallpaper-football-soccer-fire-ball-soccer-sports-football.jpg',
      originalPrice: 200,
      discountPrice: 50,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      isFavorite: false,
      count: 1,
      isShopping: false,
    ),
    ProductModel(
      id: 10,
      title: "Sun Glass",
      img:
          'https://w0.peakpx.com/wallpaper/542/929/HD-wallpaper-football-soccer-fire-ball-soccer-sports-football.jpg',
      originalPrice: 200,
      discountPrice: 50,
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      isFavorite: false,
      count: 1,
      isShopping: false,
    ),
  ];

  final List<ProductModel> _shoppingCart = [];

  List<ProductModel> get productData => _productData;

  List<ProductModel> get wishList => _wishList;

  List<ProductModel> get shoppingCart => _shoppingCart;

  final List<ProductModel> _wishList = [];

  final List<ProductModel> _productShoppingCartList = [];

  List<ProductModel> get productShoppingCartList => _productShoppingCartList;

  void setToWishlistItem(ProductModel productItem) {
    if (productItem.isFavorite) {
      wishList.add(productItem);
    } else {
      wishList.remove(productItem);
    }
    notifyListeners();
  }

  void removeToWishlist(ProductModel productItem) {
    wishList.removeWhere((item) => item.id == productItem.id);
    productItem.isFavorite = false;
    notifyListeners();
  }

  void setIsFavorite(ProductModel product) {
    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      setToWishlistItem(product);
    } else {
      removeToWishlist(product);
    }
    notifyListeners();
  }

  void updateProductShoppingCartList(ProductModel product) {
    _productShoppingCartList.add(product);
    notifyListeners();
  }

  void addToCart(int index, ProductModel product) {
    if (index >= 0 && index < productData.length) {
      if (!product.isShopping) {
        product.isShopping = true;
        updateProductShoppingCartList(product);
      } else {
        product.isShopping = false;
        _productShoppingCartList.removeWhere((item) => item.id == product.id);
      }
      notifyListeners();
    }
  }

  void removeShoppingCartListProduct(int index) {
    if (index >= 0 && index < _productShoppingCartList.length) {
      var product = _productShoppingCartList[index];
      var productIndex =
          productData.indexWhere((element) => element.id == product.id);
      if (productIndex != -1) {
        productData[productIndex].isShopping = false;
      }
      _productShoppingCartList.removeAt(index);
      notifyListeners();
    }
  }

  void toggleFavoriteStatus(ProductModel product) {
    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      _wishList.add(product);
    } else {
      _wishList.remove(product);
    }
    notifyListeners();
  }

  double getTotalAmountForCartView() {
    double total = 0.0;
    for (ProductModel product in _productShoppingCartList) {
      total += (product.count * calculateDiscountedPrice(product));
    }

    return total;
  }

  void incrementCartProduct(ProductModel product) {
    product.count++;
    notifyListeners();
  }

  void decrementCartProduct(ProductModel product) {
    if (product.count > 1) {
      product.count--;
    }
    notifyListeners();
  }

  double calculateDiscountedPrice(ProductModel product) {
    return product.originalPrice -
        (product.discountPrice * product.originalPrice) / 100;
  }

  bool isWishlistEmpty() {
    return _wishList.isEmpty;
  }

  bool isCartEmpty() {
    return _shoppingCart.isEmpty;
  }
}
