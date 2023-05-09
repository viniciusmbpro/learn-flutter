import 'package:bluetooth_control/app/pages/joystick_page/components/joystick_base_custom.dart';
import 'package:bluetooth_control/app/pages/joystick_page/components/joystick_stick_custom.dart';
import 'package:bluetooth_control/app/pages/joystick_page/controllers/joystick_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:provider/provider.dart';

const ballSize = 100.0;
const step = 50.0;

class JoystickScreen extends StatefulWidget {
  const JoystickScreen({Key? key}) : super(key: key);

  @override
  _JoystickScreenState createState() => _JoystickScreenState();
}

class _JoystickScreenState extends State<JoystickScreen> {
  double _x = 100;
  double _y = 100;
  JoystickController joystickController = JoystickController(y: 0, x: 0);

  @override
  void didChangeDependencies() {
    _x = MediaQuery.of(context).size.width / 2 - ballSize / 2;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    joystickController.carController = Provider.of(context);
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).colorScheme.primary,
          ),
          Positioned(
            top: 20,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Container(
              height: 100,
              width: 100,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  "${joystickController.carController.car.convertDataToMessage()}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Joystick(
                  base: JoystickBaseCustom(mode: JoystickMode.vertical),
                  stick: JoystickStickCustom(),
                  mode: JoystickMode.vertical,
                  listener: (details) {
                    setState(() {
                      joystickController.y = details.y;
                      joystickController.converteToSpeedDirection();
                    });
                  },
                ),
                Joystick(
                  base: JoystickBaseCustom(mode: JoystickMode.horizontal),
                  stick: JoystickStickCustom(),
                  mode: JoystickMode.horizontal,
                  listener: (details) {
                    setState(() {
                      joystickController.x = details.x;
                      joystickController.converteToSpeedDirection();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JoystickModeDropdown extends StatelessWidget {
  final JoystickMode mode;
  final ValueChanged<JoystickMode> onChanged;

  const JoystickModeDropdown(
      {Key? key, required this.mode, required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: FittedBox(
          child: DropdownButton(
            value: mode,
            onChanged: (v) {
              onChanged(v as JoystickMode);
            },
            items: const [
              DropdownMenuItem(
                  child: Text('All Directions'), value: JoystickMode.all),
              DropdownMenuItem(
                  child: Text('Vertical And Horizontal'),
                  value: JoystickMode.horizontalAndVertical),
              DropdownMenuItem(
                  child: Text('Horizontal'), value: JoystickMode.horizontal),
              DropdownMenuItem(
                  child: Text('Vertical'), value: JoystickMode.vertical),
            ],
          ),
        ),
      ),
    );
  }
}
