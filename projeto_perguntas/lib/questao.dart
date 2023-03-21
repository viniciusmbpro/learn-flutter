import 'package:flutter/material.dart';

class Questao extends StatelessWidget {
  const Questao({super.key, required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 25, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
