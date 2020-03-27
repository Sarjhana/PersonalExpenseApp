
import 'package:flutter/material.dart';

import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';  
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
       theme: ThemeData(
       primarySwatch: Colors.purple,
       accentColor: Colors.grey,
       fontFamily: 'Quicksand',

       textTheme: ThemeData.light().textTheme.copyWith(         
         title: TextStyle(
           fontFamily: 'OpenSans',
           fontSize: 18,
           fontWeight: FontWeight.bold),
           ),

       appBarTheme: AppBarTheme(
         textTheme: ThemeData.light().textTheme.copyWith(
         title: TextStyle(
           fontFamily: 'OpenSans',
           fontSize: 20,
           fontWeight: FontWeight.bold)
           )
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  //String titleInput;
  //String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final List<Transaction> _userTransactions = [
    // Transaction(id: 't1',title: 'New Shoes', amount: 40.00,date: DateTime.now(),),
    // Transaction(id: 't2',title: 'Grocery', amount: 90.00,date: DateTime.now(),),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(
          days: 7),
          ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate){
    final newTx = Transaction(
      id: DateTime.now().toString(), 
      title: txTitle, amount: txAmount,
       date: chosenDate,
       );
    setState(() {    
      _userTransactions.add(newTx);
    });

  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
        child: NewTransaction(_addNewTransaction),
        //onTap: () {},
        //behavior: HitTestBehavior.opaque,
        );
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),onPressed: () => _startAddNewTransaction(context),)
        ],
      ),
      body: SingleChildScrollView(
              child: Column( 
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
          Chart(_recentTransactions),
         TransactionList(_userTransactions,_deleteTransaction),
        ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () => _startAddNewTransaction(context),),
    );
  }
}
