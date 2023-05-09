import 'package:app_api/app/pages/components/widget_scaffold.dart';
import 'package:flutter/material.dart';

class ListDinamicaJson extends StatefulWidget {
  const ListDinamicaJson({Key? key}) : super(key: key);

  @override
  _ListDinamicaState createState() => _ListDinamicaState();
}

class _ListDinamicaState extends State<ListDinamicaJson> {
  @override
  Widget build(BuildContext context) {
    return WidgetScaffold(buildListaDinamica(), 'Entendendo Lista Dinamica');
  }

  buildListaDinamica() {
    return ListView.builder(itemBuilder: (context, index) {
      return ListTile(
        leading: Icon(Icons.arrow_back),
        title: Text('Itens da lista'),
        onTap: () {
          print("Item");
        },
      );
    });
  }
}
