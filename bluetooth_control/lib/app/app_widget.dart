import 'package:bluetooth_control/app/app_routes.dart';
import 'package:bluetooth_control/app/controllers/car_controller.dart';
import 'package:bluetooth_control/app/pages/joystick_page/joystick_page_test.dart';
import 'package:bluetooth_control/app/pages/tab_pages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CarController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bluetooth control',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Color.fromARGB(255, 39, 39, 39),
                secondary: Color.fromARGB(255, 255, 174, 0),
              ),
          textTheme: ThemeData.light().textTheme.copyWith(
                titleSmall: TextStyle(
                  fontSize: 20,
                ),
              ),
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
        ),
        // home: CategoriesScreen(),
        initialRoute: '/',
        routes: {
          AppRoutes.home: (context) => TabsScreen(),
          AppRoutes.functionalities: (context) => TabsScreen(),
        },
      ),
    );
  }
}
