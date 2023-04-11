import 'package:bluetooth_control/app/controllers/car_controller.dart';

class JoystickController {
  double y;
  double x;
  late CarController carController;

  JoystickController({
    required this.y,
    required this.x,
  });

  void converteToSpeedDirection() {
    int speed = 0;
    double yAbs = y.abs();

    if (yAbs == 0.0) {
      speed = 0;
    } else if (yAbs <= 0.2) {
      speed = 1;
    } else if (yAbs <= 0.4) {
      speed = 2;
    } else if (yAbs <= 0.5) {
      speed = 3;
    } else if (yAbs <= 0.6) {
      speed = 4;
    } else if (yAbs <= 0.8) {
      speed = 5;
    } else if (yAbs <= 1.0) {
      speed = 6;
    }
    carController.car.speed = speed;

    if (y < 0) {
      carController.car.direction = 'F';
    } else if (y > 0) {
      carController.car.direction = 'B';
    } else {
      carController.car.direction = 'S';
    }

    if (x < 0) {
      carController.car.direction += 'L';
    } else if (x > 0) {
      carController.car.direction += 'R';
    } else if (x == 0) {
      carController.car.direction += '';
    }

    carController.prepareMessage();
  }
}
