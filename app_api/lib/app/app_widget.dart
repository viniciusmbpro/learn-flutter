import 'package:app_api/app/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_api/app/settings/routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Mototáxi-app',
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Color(0xFF0D1730),
              secondary: Color(0xFF14FF01),
              tertiary: Color(0xFF67FFF6),
            ),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        // brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {
        AppRoutes.home: (context) => ListDinamicaJson(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
