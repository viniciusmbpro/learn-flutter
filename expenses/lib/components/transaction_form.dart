import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(
      {super.key, required this.onSubmit, required this.transaction});

  final Future<void> Function(String, double, DateTime) onSubmit;
  final dynamic transaction;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  var textoBtn = "Cadastrar transação";

  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      textoBtn = "Editar transação";
      setState(() {
        _titleController.text = widget.transaction.title;
        _valueController.text = widget.transaction.value.toString();
        _selectedDate = widget.transaction.date;
      });
    }
  }

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    print("$title $value $_selectedDate");

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      print("Not | $title $value $_selectedDate");
      return;
    }

    print("${widget.onSubmit.runtimeType} - 0000");

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDataPicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Título"),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Valor R\$"),
              onSubmitted: (_) => _submitForm(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? "Nenhuma data selecionada!"
                        : "Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}"),
                  ),
                  TextButton(
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDataPicker,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  child: Text(
                    textoBtn,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: _submitForm,
                  // style: ButtonStyle(
                  //     foregroundColor:
                  //         MaterialStateProperty.all(Colors.purple)),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
