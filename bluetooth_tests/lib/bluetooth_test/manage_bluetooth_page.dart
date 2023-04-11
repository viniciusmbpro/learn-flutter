import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class ManageBluetoothPage extends StatefulWidget {
  @override
  _ManageBluetoothPageState createState() => _ManageBluetoothPageState();
}

class _ManageBluetoothPageState extends State<ManageBluetoothPage> {
  FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Devices'),
      ),
      body: Container(),
    );
  }
}
