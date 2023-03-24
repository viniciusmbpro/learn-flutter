import 'dart:math';
import 'dart:io';

import 'package:expenses/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/chart.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
          error: Colors.red,
        ),
        textTheme: tema.textTheme.copyWith(
          titleSmall: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 70, 70, 70),
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;

  final _transactionService = TransactionService();
  late List<Transaction> transactionList = [
    Transaction(id: 1, title: "title", value: 100, date: DateTime.now()),
  ];

  List<Transaction> get _recentTransactions {
    return transactionList.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  Future<void> _addTransaction(
      String title, double value, DateTime date) async {
    print("addtransaction");
    final transactionAdd = Transaction(
      id: Random().nextInt(1000),
      title: title,
      value: value,
      date: date,
    );
    var result = await _transactionService.saveTransaction(transactionAdd);
    print("Add transaction ---> $result");
    if (result != null) {
      getAllTransactionDetails();
      Navigator.of(context).pop();
      _showSuccessSnackBar('Transação adicionada com Sucesso');
    }
  }

  getAllTransactionDetails() async {
    print("Linha getAllTransactionDetails");
    var transactions = await _transactionService.readAllTransactions();
    print('transactions01');
    print(transactions);

    List<Transaction> aux = [];
    transactions.forEach((tr) {
      var trModel = Transaction(
        id: tr['id'],
        title: tr['title'],
        value: tr['value'],
        date: DateTime.parse(tr['date']),
      );
      aux.add(trModel);
    });

    setState(() {
      transactionList = aux;
    });
    print(transactions);
    print(transactionList);
  }

  @override
  void initState() {
    getAllTransactionDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Color.fromARGB(255, 12, 155, 17),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, int transactionId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Tem certeza que deseja excluir',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _transactionService
                        .deleteTransaction(transactionId);
                    print("Resultado: $result");
                    if (result != null) {
                      Navigator.pop(context);
                      getAllTransactionDetails();
                      _showSuccessSnackBar('Transação deletada com Sucesso');
                    }
                  },
                  child: const Text('Deletar')),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, // foreground
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Fechar'))
            ],
          );
        });
  }

  int idEdit = 0;
  Future<void> _updateTransaction(
      String title, double value, DateTime date) async {
    final transactionEdit = Transaction(
      id: idEdit,
      title: title,
      value: value,
      date: date,
    );
    var result = await _transactionService.updateTransaction(transactionEdit);
    if (result != null) {
      Navigator.pop(context);
      getAllTransactionDetails();
      _showSuccessSnackBar('Transação editada com Sucesso');
    }
  }

  _form(form) {
    showModalBottomSheet(
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
              0, 0, 0, MediaQuery.of(context).viewInsets.bottom),
          child: form,
        );
      },
    );
  }

  _openTransactionFormModal(BuildContext context, [id]) async {
    var trModel = null;
    var result = null;
    if (id != null) {
      idEdit = id;
      result = await _transactionService.readSingleTransaction(id);
      result = result[0];
      if (result != null) {
        trModel = Transaction(
          id: result['id'],
          title: result['title'],
          value: result['value'],
          date: DateTime.parse(result['date']),
        );
      }
    }
    var form = TransactionForm(
      onSubmit: result != null ? _updateTransaction : _addTransaction,
      transaction: trModel,
    );
    _form(form);
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text(
        "Despesas pessoais",
        style: TextStyle(
          fontSize: 20 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
      actions: [
        if (isLandscape)
          IconButton(
            icon: Icon(
                _showChart ? Icons.list : Icons.insert_chart_outlined_rounded),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () =>
              _openTransactionFormModal(context, {"Texto": "Nova transação"}),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // if (isLandscape)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text("Exibir Gráfico"),
              //       Switch.adaptive(
              //         value: _showChart,
              //         onChanged: (value) {
              //           setState(() {
              //             _showChart = value;
              //           });
              //         },
              //       ),
              //     ],
              //   ),
              if (_showChart || !isLandscape)
                Container(
                  height: availableHeight * (isLandscape ? 0.7 : 0.3),
                  child: Chart(_recentTransactions),
                ),
              if (!_showChart || !isLandscape)
                Container(
                  height: availableHeight * (isLandscape ? 1 : 0.6),
                  child: TransactionList(
                    transactionList: transactionList,
                    onRemove: _deleteFormDialog,
                    onUpdate: _openTransactionFormModal,
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? null
          : FloatingActionButton(
              child: Icon(Icons.add),
              foregroundColor: Colors.black,
              onPressed: () => _openTransactionFormModal(context),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
