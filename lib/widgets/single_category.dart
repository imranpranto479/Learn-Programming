import 'package:flutter/material.dart';
import 'package:flutterd/model/post_model.dart';
import 'package:flutterd/screens/category_screens.dart';

class SingleCategory extends StatelessWidget {
  // cateogry r zonno id, lagbe title lagbe
  final Category category;
  SingleCategory(this.category);
  // category r constructor create

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            CategoryScreens.routeName,
            arguments: category.id,
          );
        },
        child: Card(
          color: Theme.of(context)
              .accentColor, // theme er subidha holo ek zaygai color change korle pura app er color change hoye zabe
          // theme -->  pura app er styling control kora zay
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              category.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
