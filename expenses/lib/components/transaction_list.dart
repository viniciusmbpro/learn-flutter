import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:expenses/components/transaction_item.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {super.key,
      required this.transactionList,
      required this.onRemove,
      required this.onUpdate});

  final List<Transaction> transactionList;
  final void Function(BuildContext, int) onRemove;
  final void Function(BuildContext, int) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: transactionList.isEmpty
            ? LayoutBuilder(
                builder: (ctx, constraints) {
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      Container(
                        height: constraints.maxHeight * 0.1,
                        child: Text(
                          'Nenhuma transação cadastrada!',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  );
                },
              )
            : ListView.builder(
                itemCount: transactionList.length,
                itemBuilder: (ctx, index) {
                  final tr = transactionList[index];
                  return TransactionItem(
                    key: GlobalObjectKey(tr.id),
                    tr: tr,
                    onRemove: onRemove,
                    onUpdate: onUpdate,
                  );
                },
              )
        // ListView(
        //     children: transactionList.map((tr) {
        //       return TransactionItem(
        //         key: ValueKey(tr.id),
        //         tr: tr,
        //         onRemove: onRemove,
        //       );
        //     }).toList(),
        //   );
        );
  }
}
