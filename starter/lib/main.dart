import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fooderlich_theme.dart';
import 'home.dart';
import 'models/grocery_manager.dart';
import 'models/tab_manager.dart';

void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.light();
    return MaterialApp(
        theme: theme,
        title: 'Fooderlich',
        // TODO: Replace this with MultiProvider
        home: MultiProvider(providers: [
          ChangeNotifierProvider<TabManager>(create: (context) => TabManager()),
          ChangeNotifierProvider<GroceryManager>(
              create: (context) => GroceryManager())
        ], child: const Home()));
  }
}
