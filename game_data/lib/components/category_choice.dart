import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'categories.dart';
import 'list_category_games.dart';

class CategoryChoice extends StatefulWidget {
  const CategoryChoice({super.key});

  @override
  State<CategoryChoice> createState() => _CategoryChoiceState();
}

class _CategoryChoiceState extends State<CategoryChoice> {
  var category = null;
  onCategory(String name) {
    setState(() {
      if (category != name) {
        category = name;
      } else if (category == name) {
        category = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Categories(onCategory: onCategory),
        if (category != null) ListCategoryGames(category: category),
      ],
    );
  }
}
