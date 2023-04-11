import 'package:flutter/material.dart';

class JoystickStickCustom extends StatelessWidget {
  const JoystickStickCustom({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 32, 32, 32).withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 39, 39, 39),
            Color.fromARGB(255, 39, 39, 39),
          ],
        ),
      ),
    );
  }
}
