import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {

  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()
    ).then((pickedDate) {
      if(pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
  return Card(
    child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(
                labelText: "Title"
            ),
            controller: _titleController,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                labelText: "Amount"
            ),
            controller: _amountController,
          ),
          Row(
            children: [
              Text(_selectedDate != null ? DateFormat.yMMMd().format(_selectedDate) : 'No Date chosen'),
              FlatButton(
                child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold)),
                textColor: Theme.of(context).primaryColor,
                onPressed: _showDatePicker
              )
            ],
          ),
          RaisedButton(
            child: Text("Add transaction"),
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
            onPressed: () {
              widget.addTx(_titleController.text, double.parse(_amountController.text), _selectedDate);
              //closing the top-most page that is opened, in this case the bottom sheet
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    ),
  );
  }
}