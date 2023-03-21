import 'package:flutter/material.dart';
import './textField.dart';

main() => runApp(const TempoEncher());

class _TempoEncherState extends State<TempoEncher> {
  double tempo = 0;
  double totalLitros = 0;
  double minutosVazao = 0;
  double litrosVazao = 0;

  void setMinutosVazao(String value) {
    minutosVazao = double.parse(value);
  }

  void setLitrosVazao(String value) {
    litrosVazao = double.parse(value);
  }

  void setTotalLitros(String value) {
    totalLitros = double.parse(value);
  }

  void calcularTempo(String value) {
    setState(() {
      final double vazao = minutosVazao / litrosVazao;
      tempo = vazao * totalLitros;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 32, 32, 32),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 32, 32, 32),
          title: const Text(
            'Calcule o tempo para encher!',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        body: Column(
          children: [
            Row(children: [
              Expanded(
                child: Column(children: [
                  Container(
                    color: Color.fromARGB(255, 0, 37, 54),
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text(
                      'Vazão:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Text(
                    'Tempo: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  TextFieldVazao(
                      texto: "Em minutos...",
                      calcularTempo: calcularTempo,
                      setValor: setMinutosVazao),
                  Text(
                    'Quantidade: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  TextFieldVazao(
                      texto: "Em litros...",
                      calcularTempo: calcularTempo,
                      setValor: setLitrosVazao),
                  Text(
                    'Total de litros para encher: ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  TextFieldVazao(
                      texto: "Em litros...",
                      calcularTempo: calcularTempo,
                      setValor: setTotalLitros),
                ]),
              ),
            ]),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 0, 37, 54),
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text(
                      'Tempo para encher = $tempo min.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TempoEncher extends StatefulWidget {
  const TempoEncher({super.key});

  @override
  _TempoEncherState createState() {
    return _TempoEncherState();
  }
}
