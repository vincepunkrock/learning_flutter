import 'package:expense_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.blue,
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText2: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.w500
          ),
          button: TextStyle(color: Colors.white),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<Transaction> _userTransactions = [
//    Transaction(
//        id: 't1', title: 'New shoes', amount: 49.99, date: DateTime.now()),
//    Transaction(id: 't2', title: 'Meal', amount: 12.99, date: DateTime.now())
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7)
          )
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    if(title == "" || amount < 0 || date == null) {
      return;
    }
    final newTx = Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: date);
    setState((){
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (bCtx) {
        return NewTransaction(_addNewTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () { _startAddNewTransaction(context); },
          ),
        ]
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Chart(_recentTransactions),
          Expanded( child: TransactionList(_userTransactions, _deleteTransaction)),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddNewTransaction(context);
        },
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
