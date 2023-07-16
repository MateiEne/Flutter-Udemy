import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

import 'model/transaction.dart';

void main() {
  //if u want your app to not be able to be in landscape mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );

  runApp(const ExpensePlanner());
}

class ExpensePlanner extends StatelessWidget {
  const ExpensePlanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'OpenSans',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  bool _showChart = false;

  void _addNewTransaction(String title, double amount, DateTime date) {
    final Transaction transaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransactions.add(transaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _delenteTransaction(Transaction transaction) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == transaction.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    final _isLanscape = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: _isLanscape
            ? Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Show chart'),
                      Switch(
                        value: _showChart,
                        onChanged: (value) {
                          setState(() {
                            _showChart = value;
                          });
                        },
                      ),
                    ],
                  ),
                  _showChart
                      ? Container(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.7,
                          child: Chart(_recentTransactions),
                        )
                      : Container(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.7,
                          child: TransactionList(_userTransactions, _delenteTransaction),
                        ),
                ],
              )
            : Column(
                children: <Widget>[
                  Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Chart(_recentTransactions),
                  ),
                  Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: TransactionList(_userTransactions, _delenteTransaction),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
