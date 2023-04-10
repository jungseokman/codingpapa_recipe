import 'package:flutter/foundation.dart';

class TabManager extends ChangeNotifier {
  int _selectedTab = 0;

  int get selectedTab {
    return _selectedTab;
  }

  void goToTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToRecipe() {
    _selectedTab = 1;
    notifyListeners();
  }
}
