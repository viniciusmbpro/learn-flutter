import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_data/pages/my_home_page.dart';

main() => runApp(const GameDataApp());

class GameDataApp extends StatelessWidget {
  const GameDataApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Color.fromARGB(255, 255, 121, 72),
          secondary: Colors.white,
          tertiary: Color(0xFFEED600),
          error: Colors.red,
        ),
        textTheme: tema.textTheme.copyWith(
          titleSmall: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 24, 24, 24)),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
