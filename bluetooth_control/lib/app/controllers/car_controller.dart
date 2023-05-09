import 'package:bluetooth_control/app/models/bluetooth_model.dart';
import 'package:bluetooth_control/app/models/car_model.dart';
import 'package:flutter/material.dart';

class CarController with ChangeNotifier {
  BluetoothModel? _bluetoothInstance;
  CarModel car = CarModel(speed: 0, direction: 'S');

  CarController();

  void createConnection(serverAdress) {
    _bluetoothInstance = BluetoothModel(serverAddress: serverAdress);
    notifyListeners();
  }

  void setConnection(existingConnection) {
    _bluetoothInstance = BluetoothModel(existingConnection: existingConnection);
    notifyListeners();
  }

  void prepareMessage() {
    if (_bluetoothInstance != null) {
      String text = car.convertDataToMessage();
      _bluetoothInstance!.sendMessage(text);
      notifyListeners();
    }
  }
}
