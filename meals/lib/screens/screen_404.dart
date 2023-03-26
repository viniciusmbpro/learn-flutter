import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Screen404 extends StatelessWidget {
  const Screen404({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Página não encontrada!"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(40),
          margin: EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "A página que você procura não existe ou ainda não foi configurada pelo app, erro 404!",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
