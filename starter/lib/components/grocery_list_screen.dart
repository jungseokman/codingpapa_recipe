import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/grocery_item.dart';
import '../models/grocery_manager.dart';
import '../screens/grocery_items_screen.dart';
import 'grocery_tile.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groceryManager = Provider.of<GroceryManager>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            final itemName = groceryManager.groceryItems[index].name;
            return Dismissible(
              onDismissed: (direction) {
                groceryManager.deleteItem(index);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$itemName is deleted')));
              },
              direction: DismissDirection.endToStart,
              background: Container(
                color: groceryManager.groceryItems[index].color,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              key: Key(groceryManager.groceryItems[index].id),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return GroceryItemScreen(
                      onCreate: (GroceryItem groceryItem) {},
                      onUpdate: (GroceryItem groceryItem) {
                        groceryManager.updateItem(groceryItem, index);
                      },
                      originalItem: groceryManager.groceryItems[index],
                    );
                  }));
                },
                child: GroceryTile(
                  groceryItem: groceryManager.groceryItems[index],
                  onComplete: (checked) {
                    groceryManager.completedItem(index, checked ?? false);
                  },
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 8,
            );
          },
          itemCount: groceryManager.groceryItems.length),
    );
  }
}
