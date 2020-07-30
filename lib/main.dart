import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MyHomePage(),
        theme: ThemeData(
          primarySwatch: Colors.purple,
          primaryColor: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                button: TextStyle(
                  color: Colors.white,
                ),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ))),
        ),
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

  bool _isChartShown = true;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String title, double amount, DateTime transactionDate) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      dateTime: transactionDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
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
    final mQuery = MediaQuery.of(context);
    final isLandscape = mQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      actions: [
        IconButton(
          tooltip: 'Add a transaction',
          icon: Icon(Icons.add),
          onPressed: () => _bringUpModal(context),
        )
      ],
      title: Text('~ Expenses ~'),
    );

    final txListWidget = Container(
      child: TransactionList(_userTransactions, _deleteTransaction),
      height: (mQuery.size.height -
              appBar.preferredSize.height -
              mQuery.padding.top) *
          0.70,
    );

    return MaterialApp(
      title: 'My Flutter App!',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple,
        accentColor: Colors.amber,
        // errorColor: Colors.red,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              button: TextStyle(
                color: Colors.white,
              ),
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
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Show chart'),
                    Switch(
                      value: _isChartShown,
                      onChanged: (isTrue) {
                        setState(() {
                          _isChartShown = !_isChartShown;
                        });
                      },
                    ),
                  ],
                ),
              if (!isLandscape)
                Container(
                  height: (mQuery.size.height -
                          appBar.preferredSize.height -
                          mQuery.padding.top) *
                      0.30,
                  child: Chart(_recentTransactions),
                ),
              if (!isLandscape) txListWidget,
              if (isLandscape)
                _isChartShown
                    ? Container(
                        height: (mQuery.size.height -
                                appBar.preferredSize.height -
                                mQuery.padding.top) *
                            0.70,
                        child: Chart(_recentTransactions),
                      )
                    : txListWidget,
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Platform.isIOS
            ? Container()
            : FloatingActionButton(
                tooltip: 'Add a transaction',
                child: Icon(Icons.add),
                onPressed: () => _bringUpModal(context),
              ),
      ),
    );
  }
}
