import 'package:flutter/material.dart';

class TextFieldVazao extends StatelessWidget {
  const TextFieldVazao(
      {super.key,
      required this.texto,
      required this.calcularTempo,
      required this.setValor});

  final String texto;
  final void Function(String) calcularTempo;
  final void Function(String) setValor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(20),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 0, 37, 54), // define a cor de fundo
          labelText: texto, // rótulo do campo de texto
          labelStyle: TextStyle(
              color:
                  Color.fromARGB(255, 138, 238, 255)), // define a cor do rótulo
          hintStyle: TextStyle(
              color: Color.fromARGB(
                  255, 138, 238, 255)), // define a cor do texto de dica
          border: OutlineInputBorder(
            // define a cor da borda
            borderSide: BorderSide(color: Color.fromARGB(255, 21, 255, 0)),
          ),
          enabledBorder: OutlineInputBorder(
            // define a cor da borda quando o campo não está selecionado
            borderSide: BorderSide(color: Color.fromARGB(255, 102, 102, 102)),
          ),
          focusedBorder: OutlineInputBorder(
            // define a cor da borda quando o campo está selecionado
            borderSide: BorderSide(color: Color.fromARGB(255, 138, 238, 255)),
          ),
        ),
        style:
            TextStyle(color: Color.fromARGB(255, 138, 238, 255), fontSize: 20),
        onChanged: (value) {
          setValor(value);
          calcularTempo(value);
        },
      ),
    );
  }
}
