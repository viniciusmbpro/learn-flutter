import 'package:flutter/material.dart';
import './resultado.dart';
import './questionario.dart';

main() => runApp(const PerguntaApp());

class _PerguntaAppState extends State<PerguntaApp> {
  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;

  final List<Map<String, Object>> _perguntas = const [
    {
      'texto': "Qual é a sua cor favorita ?",
      'respostas': [
        {'texto': 'Preto', 'pontuacao': 10},
        {'texto': 'Vermelho', 'pontuacao': 2},
        {'texto': 'Verde', 'pontuacao': 3},
        {'texto': 'Azul', 'pontuacao': 4},
      ]
    },
    {
      'texto': "Qual é o seu animal favorito ?",
      'respostas': [
        {'texto': 'Macaco', 'pontuacao': 10},
        {'texto': 'Elefante', 'pontuacao': 6},
        {'texto': 'Gato', 'pontuacao': 2},
        {'texto': 'Cachorro', 'pontuacao': 1},
      ]
    },
    {
      'texto': "Como declarar um construtor de um Widget ?",
      'respostas': [
        {'texto': 'const MeuWidget({super.key});', 'pontuacao': 10},
        {'texto': 'var MeuWidget({super.key});', 'pontuacao': 8},
        {'texto': 'MeuWidget({super.key});', 'pontuacao': 5},
        {'texto': 'int MeuWidget({super.key});', 'pontuacao': 2}
      ]
    },
  ];

  void _responder(int pontuacao) {
    if (temPerguntaSelecionada) {
      setState(() {
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });
    }
  }

  void _reiniciarQuestionario() {
    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }

  bool get temPerguntaSelecionada {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 19, 53),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 19, 53),
          title: const Text(
            'Perguntas genéricas',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        body: temPerguntaSelecionada
            ? Questionario(
                perguntas: _perguntas,
                perguntaSelecionada: _perguntaSelecionada,
                quandoResponder: _responder)
            : Resultado(
                pontuacaoTotal: _pontuacaoTotal,
                quandoReiniciarQuestionario: _reiniciarQuestionario,
              ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PerguntaApp extends StatefulWidget {
  const PerguntaApp({super.key});

  @override
  _PerguntaAppState createState() {
    return _PerguntaAppState();
  }
}
