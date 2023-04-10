import 'package:flutter/foundation.dart';

import 'grocery_item.dart';

class GroceryManager extends ChangeNotifier {
  final List<GroceryItem> _items = <GroceryItem>[];

  // read
  List<GroceryItem> get groceryItems => List.unmodifiable(_items);

  //create
  void addItem(GroceryItem item) {
    _items.add(item);
    notifyListeners();
  }

  //update
  void updateItem(GroceryItem item, int index) {
    _items[index] = item;
    notifyListeners();
  }

  //delete
  void deleteItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void completedItem(int index, bool complete) {
    final item = _items[index];
    _items[index] = item.copyWith(isComplete: complete);
    notifyListeners();
  }
}
