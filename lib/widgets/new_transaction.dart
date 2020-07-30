import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _onSubmit() {
    if (_amountController.text.isEmpty) return;
    final String enteredTitle = _titleController.text;
    final double enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTransaction(_titleController.text,
        double.parse(_amountController.text), _selectedDate);
    Navigator.of(context).pop();
    //pop the modal off the screen after submitting data
  }

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
    print('Date picker opened');
  }

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    return Container(
      child: SingleChildScrollView(
        child: Card(
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: mQuery.viewInsets.bottom + 10,
              left: 10,
              right: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  keyboardType: TextInputType.name,
                  controller: _titleController,
                  onSubmitted: (_) => _onSubmit(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  onSubmitted: (_) => _onSubmit(),
                ),
                Container(
                  height: 70,
                  child: Row(children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    FlatButton(
                      child: Text(
                        'Choose date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textColor: Colors.purple,
                      onPressed: () => _pickDate(),
                    )
                  ]),
                ),
                RaisedButton(
                  child: Text(
                    'Add transaction',
                  ),
                  textColor: Theme.of(context).textTheme.button.color,
                  color: Colors.purple,
                  onPressed: _onSubmit,
                )
              ],
            ),
          ),
          elevation: 8,
        ),
      ),
    );
  }
}
