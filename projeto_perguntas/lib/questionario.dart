import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

class Questionario extends StatelessWidget {
  const Questionario({
    super.key,
    required this.perguntas,
    required this.perguntaSelecionada,
    required this.quandoResponder,
  });

  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int) quandoResponder;

  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas = temPerguntaSelecionada
        ? perguntas[perguntaSelecionada]['respostas']
            as List<Map<String, Object>>
        : [];
    List<Widget> widgets = respostas
        .map((resp) => Resposta(
            texto: resp['texto'] as String,
            quandoSelecionado: () =>
                quandoResponder(int.parse(resp['pontuacao'].toString()))))
        .toList();

    return Column(
      children: <Widget>[
        Questao(texto: perguntas[perguntaSelecionada]['texto'] as String),
        ...widgets,
      ],
    );
  }
}
