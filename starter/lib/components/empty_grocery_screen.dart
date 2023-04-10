import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tab_manager.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: AspectRatio(
            child: Image.asset('assets/fooderlich_assets/empty_list.png'),
            aspectRatio: 1,
          ),
        ),
        Text(
          'No Groceries',
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Shopping for ingredients? Write them down!',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        MaterialButton(
          onPressed: () {
            Provider.of<TabManager>(context, listen: false).goToRecipe();
          },
          textColor: Colors.white,
          height: 36,
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Text('Browse Recipe'),
        )
      ],
    );
  }
}
