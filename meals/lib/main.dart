import 'package:flutter/material.dart';
import 'package:meals/screens/categories_meals_screen.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import 'package:meals/screens/screen_404.dart';
import 'package:meals/screens/tabs_screens.dart';

import 'package:meals/screens/settings_screen.dart';

import 'package:meals/utils/app_routes.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Settings settings = Settings();

  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      this.settings = settings;
      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten &&
            !filterLactose &&
            !filterVegan &&
            !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.pink,
              secondary: Colors.amber,
            ),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        AppRoutes.HOME: (context) => TabsScreen(favoriteMeals: _favoriteMeals),
        AppRoutes.CATEGORIES_MEALS: (context) =>
            CategoriesMealsScreen(meals: _availableMeals),
        AppRoutes.MEAL_DETAIL: (context) => MealDetailScreen(
            onToggleFavorite: _toggleFavorite, isFavorite: _isFavorite),
        AppRoutes.SETTINGS: (context) =>
            SettingsScreen(onSettingsChanged: _filterMeals, settings: settings),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/alguma-coisa') {
          return null;
        } else if (settings.name == '/outra-coisa') {
          return null;
        } else {
          return MaterialPageRoute(builder: (_) {
            return const Screen404();
          });
        }
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) {
          return const Screen404();
        });
      },
    );
  }
}
