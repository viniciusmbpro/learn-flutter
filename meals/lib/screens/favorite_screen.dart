import 'package:flutter/material.dart';

import '../models/meal.dart';

import 'package:meals/components/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key, required this.favoriteMeals});

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Nenhuma refeição foi marcada como favorita.',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(meal: favoriteMeals[index]);
        },
      );
    }
  }
}
