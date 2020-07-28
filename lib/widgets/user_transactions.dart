import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: '1',
        amount: 69.99,
        dateTime: DateTime.now(),
        title: 'MAH NEW SHOES'),
    Transaction(
        id: '2', amount: 399, dateTime: DateTime.now(), title: 'MAH NEW BED'),
    Transaction(
        id: '3',
        amount: 1399,
        dateTime: DateTime.now(),
        title: 'MAH NEW GROCERIES'),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
