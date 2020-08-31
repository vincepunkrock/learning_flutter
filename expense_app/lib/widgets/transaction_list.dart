import 'package:expense_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {

  final List<Transaction> transactions;
  final Function _deleteTransaction;

  TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {

    return Container(
      child: transactions.isEmpty ?
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
              "No transactions added yet!", textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            height: 100,
            child: Image.asset("assets/images/waiting.png"),
          ),
        ]
      ) :
      ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index)
        {
          final tx = transactions[index];
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
        },
    ),

    );
  }
}