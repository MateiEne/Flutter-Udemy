import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this._transactions, this.deleteTransaction, {Key? key}) : super(key: key);

  final List<Transaction> _transactions;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _transactions.isEmpty
          ? LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Column(
                  children: <Widget>[
                    const Text('No transactions added yet'),
                    SizedBox(
                      height: constraints.maxHeight * 0.1,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FittedBox(
                          child: Text("\$${_transactions[index].amount}"),
                        ),
                      ),
                    ),
                    title: Text(
                      _transactions[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(_transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 400
                        ? FlatButton.icon(
                            onPressed: () => deleteTransaction(_transactions[index]),
                            icon: const Icon(
                              Icons.delete,
                            ),
                            label: Text('Delete'),
                          )
                        : IconButton(
                            icon: const Icon(
                              Icons.delete,
                            ),
                            onPressed: () => deleteTransaction(_transactions[index]),
                          ),
                  ),
                );
              },
            ),
    );
  }
}
