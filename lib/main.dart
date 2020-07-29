import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: '1',
    //     amount: 69.99,
    //     dateTime: DateTime.now(),
    //     title: 'MAH NEW SHOES'),
    // Transaction(
    //     id: '2', amount: 399, dateTime: DateTime.now(), title: 'MAH NEW BED'),
    // Transaction(
    //     id: '3',
    //     amount: 1399,
    //     dateTime: DateTime.now(),
    //     title: 'MAH NEW GROCERIES'),
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      dateTime: DateTime.now(),
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _bringUpModal(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App!',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ))),
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              tooltip: 'Add a transaction',
              icon: Icon(Icons.add),
              onPressed: () => _bringUpModal(context),
            )
          ],
          title: Text('~ Expenses ~'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Text('Chart.'),
                elevation: 5,
              ),
              TransactionList(_userTransactions),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add a transaction',
          child: Icon(Icons.add),
          onPressed: () => _bringUpModal(context),
        ),
      ),
    );
  }
}
