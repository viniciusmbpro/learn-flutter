import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'serial_test/MainPage.dart';

void main() => runApp(new ExampleApplication());

class ExampleApplication extends StatelessWidget {
  Future<void> requestPermissions(BuildContext context) async {
    Map<Permission, PermissionStatus> results = await [
      Permission.location,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.bluetoothScan,
    ].request();
    print(results);
  }

  @override
  Widget build(BuildContext context) {
    requestPermissions(context);
    return MaterialApp(home: MainPage());
  }
}
