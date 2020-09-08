import 'package:expense_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'transaction_item.dart';

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
          return TransactionItem(tx: tx, deleteTransaction: _deleteTransaction);
        },
    ),

    );
  }
}
