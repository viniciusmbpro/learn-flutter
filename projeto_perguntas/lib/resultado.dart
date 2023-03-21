import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  const Resultado(
      {super.key,
      required this.pontuacaoTotal,
      required this.quandoReiniciarQuestionario});

  final int pontuacaoTotal;
  final void Function() quandoReiniciarQuestionario;

  String get fraseResultado {
    if (pontuacaoTotal < 8) {
      return 'Parabéns!';
    } else if (pontuacaoTotal < 12) {
      return 'Você é bom!';
    } else if (pontuacaoTotal < 16) {
      return 'Impressionante!';
    } else {
      return 'Nível Jedi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              fraseResultado,
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.black54,
              foregroundColor: Colors.amberAccent,
            ),
            onPressed: quandoReiniciarQuestionario,
            child: const Text("Reiniciar?"),
          )
        ]);
  }
}
