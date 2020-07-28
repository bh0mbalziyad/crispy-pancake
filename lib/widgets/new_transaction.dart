import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void onSubmit() {
    final String enteredTitle = titleController.text;
    final double enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTransaction(
      titleController.text,
      double.parse(amountController.text),
    );
    Navigator.of(context).pop();
    //pop the modal off the screen after submitting data
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              keyboardType: TextInputType.name,
              controller: titleController,
              onSubmitted: (_) => onSubmit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              controller: amountController,
              onSubmitted: (_) => onSubmit(),
            ),
            FlatButton(
              child: Text(
                'Add transaction',
              ),
              textColor: Colors.purple,
              onPressed: onSubmit,
            )
          ],
        ),
      ),
      elevation: 8,
    ));
  }
}
