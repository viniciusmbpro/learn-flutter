import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _input = "";

  void buttonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case 'C':
          _output = "0";
          _input = "";
          break;
        case '⌫':
          _input = _input.substring(0, _input.length - 1);
          _output = _input.isEmpty ? "0" : _input;
          break;
        case '%':
          _output = (double.parse(_output) / 100).toString();
          _input = _output;
          break;
        case '÷':
        case '×':
        case '-':
        case '+':
          _input += " $buttonText ";
          break;
        case '±':
          _output = (double.parse(_output) * -1).toString();
          _input = _output;
          break;
        case '.':
          if (!_output.contains('.')) {
            _output += buttonText;
            _input = _output;
          }
          break;
        case '=':
          _output = _evaluate();
          _input = _output;
          break;
        default:
          if (_output == "0") {
            _output = buttonText;
          } else {
            _output += buttonText;
          }
          _input = _output;
      }
    });
  }

  String _evaluate() {
    Parser p = Parser();
    Expression exp = p.parse(_input.replaceAll('×', '*').replaceAll('÷', '/'));
    ContextModel cm = ContextModel();
    return exp.evaluate(EvaluationType.REAL, cm).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              height: constraints.maxHeight * .3,
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    _output,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    _input,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1),
            Container(
              height: constraints.maxHeight * .7 - 1,
              child: GridView.count(
                crossAxisCount: 4,
                children: <Widget>[
                  CalculatorButton(
                    text: 'C',
                    textColor: Colors.white,
                    backgroundColor: Colors.grey,
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '⌫',
                    textColor: Colors.white,
                    backgroundColor: Colors.grey,
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '%',
                    textColor: Colors.white,
                    backgroundColor: Colors.grey,
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '÷',
                    textColor: Colors.white,
                    backgroundColor: Colors.orange,
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '7',
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '8',
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '9',
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '×',
                    textColor: Colors.white,
                    backgroundColor: Colors.orange,
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '4',
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '5',
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '6',
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '-',
                    textColor: Colors.white,
                    backgroundColor: Colors.orange,
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '1',
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '2',
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '3',
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '+',
                    textColor: Colors.white,
                    backgroundColor: Colors.orange,
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '±',
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '0',
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '.',
                    onPressed: () {},
                  ),
                  CalculatorButton(
                    text: '=',
                    textColor: Colors.white,
                    backgroundColor: Colors.orange,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Function onPressed;

  const CalculatorButton({
    Key? key,
    required this.text,
    this.textColor = Colors.black,
    this.backgroundColor = Colors.white,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(1),
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        color: backgroundColor,
        height: double.infinity,
        minWidth: double.infinity,
      ),
    );
  }
}
