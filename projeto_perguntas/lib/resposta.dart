import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  const Resposta(
      {super.key, required this.texto, required this.quandoSelecionado});

  final String texto;

  final void Function() quandoSelecionado;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 0, 136, 52),
            foregroundColor: Colors.white),
        onPressed: quandoSelecionado,
        child: Text(texto),
      ),
    );
  }
}
