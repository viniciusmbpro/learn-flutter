import 'package:bluetooth_control/app/controllers/car_controller.dart';
import 'package:bluetooth_control/app/pages/bluetooth_page/MainPage.dart';
import 'package:bluetooth_control/app/pages/bluetooth_test/blue_page_test.dart';
import 'package:bluetooth_control/app/pages/bluetooth_test/blue_page_test_serial.dart';
import 'package:bluetooth_control/app/pages/joystick_page/joystick_page.dart';
import 'package:bluetooth_control/app/pages/joystick_page/joystick_page_test.dart';
import 'package:bluetooth_control/app/components/main_drawer.dart';
import 'package:bluetooth_control/app/pages/bluetooth_test/manage_bluetooth_page.dart';
import 'package:bluetooth_control/app/pages/tilt_controls_page/tilt_controls_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;

  late List<Map<String, Object>> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        "title": "Joystick principal",
        "screen": JoystickScreen(),
      },
      {
        "title": "Tilt controls",
        "screen": TiltControlsPage(),
      },
      {
        "title": "Tipos de joystick",
        "screen": JoystickScreenTest(),
      },
      {
        "title": "Bluetooths",
        "screen": MainPage(),
      },
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      body: _screens[_selectedScreenIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedScreenIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.control_camera_rounded),
            label: 'Joystick',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sensors),
            label: 'Sensores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Tipos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bluetooth_searching_rounded),
            label: 'Bluetooths',
          ),
        ],
      ),
    );
  }
}
