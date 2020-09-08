
import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.tx,
    @required Function deleteTransaction,
  }) : _deleteTransaction = deleteTransaction, super(key: key);

  final Transaction tx;
  final Function _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
          children: [
            Container(
              child: Text(
                '\$ ${tx.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).primaryColor
                ),
              ),
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.all(8),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx.title,
                    style: Theme.of(context).textTheme.bodyText1),
                Text(DateFormat.yMMMd().format(tx.date)),
              ],
            ),
            Expanded(child:
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () {
                    _deleteTransaction(tx.id);
                  },
                ),]
              ),
            ),
          ],
        ),
    );
  }
}