import 'package:bluetooth_control/app/controllers/car_controller.dart';

class TiltControlsController {
  double yDirection;
  double zSpeed;
  late CarController carController;

  TiltControlsController({
    required this.yDirection,
    required this.zSpeed,
  });

  void converteToSpeedDirection() {
    int speed = 0;
    double zAbs = zSpeed.abs();

    if (zAbs <= 2.0) {
      speed = 0;
    } else if (zAbs <= 3.0) {
      speed = 1;
    } else if (zAbs <= 4.0) {
      speed = 2;
    } else if (zAbs <= 5.0) {
      speed = 3;
    } else if (zAbs <= 6.0) {
      speed = 4;
    } else if (zAbs <= 7.0) {
      speed = 5;
    } else if (zAbs <= 8.0) {
      speed = 6;
    }
    carController.car.speed = speed;

    if (zSpeed > 2.0) {
      carController.car.direction = 'F';
    } else if (zSpeed < -2.0) {
      carController.car.direction = 'B';
    } else {
      carController.car.direction = 'S';
    }

    if (yDirection < -4.0) {
      carController.car.direction += 'L';
    } else if (yDirection > 4.0) {
      carController.car.direction += 'R';
    } else {
      carController.car.direction += '';
    }

    carController.prepareMessage();
  }
}
