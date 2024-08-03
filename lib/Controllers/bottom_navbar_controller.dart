import 'package:flutter/foundation.dart';

class BottomNavbarController extends ChangeNotifier {
  int _navBarIndex = 0;

  int get navBarIndex => _navBarIndex;

  set setNavBarIndex(int index) {
    _navBarIndex = index;
    refreshNavbar();
  }

  void refreshNavbar() {
    notifyListeners();
  }
}
