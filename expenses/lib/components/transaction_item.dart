import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.tr,
    required this.onRemove,
    required this.onUpdate,
  });

  final Transaction tr;
  final void Function(BuildContext, int) onRemove;
  final void Function(BuildContext, int) onUpdate;

  static const colors = [
    Color.fromARGB(255, 124, 8, 0),
    Color.fromARGB(255, 98, 0, 116),
    Color.fromARGB(255, 121, 72, 0),
    Color.fromARGB(255, 0, 58, 105),
    Color.fromARGB(255, 41, 41, 41),
  ];

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? _backgroundColor;

  @override
  void initState() {
    super.initState();

    int i = Random().nextInt(5);
    _backgroundColor = TransactionItem.colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
          leading: CircleAvatar(
            radius: 35,
            backgroundColor: _backgroundColor,
            foregroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: FittedBox(child: Text("R\$${widget.tr.value}")),
            ),
          ),
          title: Text(
            widget.tr.title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          subtitle: Text(
            DateFormat("d MMMM y | H:m").format(widget.tr.date),
          ),
          trailing: MediaQuery.of(context).size.width > 480
              ? Container(
                  width: 200,
                  child: Row(
                    children: [
                      TextButton.icon(
                        onPressed: () => widget.onUpdate(context, widget.tr.id),
                        icon: Icon(Icons.edit, color: Colors.blue[700]),
                        label: Text(
                          'Editar',
                          style: TextStyle(color: Colors.blue[700]),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () => widget.onRemove(context, widget.tr.id),
                        icon: Icon(Icons.delete, color: Colors.red),
                        label: Text(
                          'Excluir',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.blue[700],
                        onPressed: () => widget.onUpdate(context, widget.tr.id),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                        onPressed: () => widget.onRemove(context, widget.tr.id),
                      ),
                    ],
                  ),
                )),
    );
  }
}
