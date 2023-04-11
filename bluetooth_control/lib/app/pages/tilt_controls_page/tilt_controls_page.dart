import 'dart:async';

import 'package:bluetooth_control/app/pages/tilt_controls_page/controllers/tilt_controls_controller.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/material.dart';

class TiltControlsPage extends StatefulWidget {
  const TiltControlsPage({Key? key}) : super(key: key);

  @override
  _TiltControlsPageState createState() => _TiltControlsPageState();
}

class _TiltControlsPageState extends State<TiltControlsPage> {
  AccelerometerEvent varAccelerometerEvent = AccelerometerEvent(0, 0, 0);
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  TiltControlsController tiltControlsController = TiltControlsController(
    yDirection: 0,
    zSpeed: 0,
  );

  @override
  void initState() {
    super.initState();
    _accelerometerSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        varAccelerometerEvent = event;
        tiltControlsController.zSpeed = event.z;
        tiltControlsController.yDirection = event.y;
        tiltControlsController.converteToSpeedDirection();
      });
    });
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    tiltControlsController.carController = Provider.of(context);
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.primary,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            child: Text(
              "AccelerometerEvent:\nX: ${varAccelerometerEvent.x}\nY: ${varAccelerometerEvent.y}\nZ: ${varAccelerometerEvent.z}",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.primary,
                ),
                Positioned(
                  top: (varAccelerometerEvent.y + 10) *
                          (MediaQuery.of(context).size.height * 0.7 / 20) -
                      (((varAccelerometerEvent.z + 10) * 10)),
                  right: (varAccelerometerEvent.x + 10) *
                          (MediaQuery.of(context).size.width / 20) -
                      (((varAccelerometerEvent.z + 10) * 10)),
                  // 300 - 100
                  // 20 - x
                  child: Container(
                    height: (varAccelerometerEvent.z + 10) * 10,
                    width: (varAccelerometerEvent.z + 10) * 10,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "${tiltControlsController.carController.car.convertDataToMessage()}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
