import 'package:bluetooth_control/app/models/bluetooth_model.dart';
import 'package:bluetooth_control/app/models/car_model.dart';
import 'package:flutter/material.dart';

class CarController with ChangeNotifier {
  BluetoothModel? _bluetoothConnection;
  CarModel car = CarModel(speed: 0, direction: 'S');

  CarController();

  void prepareMessage() {
    if (_bluetoothConnection != null) {
      String text = car.convertDataToMessage();
      _bluetoothConnection!.sendMessage(text);
      notifyListeners();
    }
  }

  void createConnection(serverAdress) {
    _bluetoothConnection = BluetoothModel(serverAddress: serverAdress);
    notifyListeners();
  }

  void getConnection(conn) {
    _bluetoothConnection = conn;
    notifyListeners();
  }
}
