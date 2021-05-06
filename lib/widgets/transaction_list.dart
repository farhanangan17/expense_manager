import 'package:expense_manager/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList(this.transaction, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print('build() TransactionList');

    return
      // Container(
      // height: MediaQuery.of(context).size.height*0.7,
      // // child: SingleChildScrollView(
      //   child:
        transaction.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints){
              return Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'No transaction added yet!',
                      style: Theme.of(context).textTheme.title,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/download.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
            : ListView(
              children: transaction.map((tx) => TransactionItem(
                  //this key is also used in transaction list's root widget
                  // this key has identified a certain item with its unique id so that's why colors remian same.
                  key: ValueKey(tx.id),
                  transaction: tx,
                  deleteTx: deleteTx,
                )).toList(),
            // this could be used if only ListView is used in stead of ListView.builder
              //   itemBuilder: (cntx, index){
              //     return TransactionItem(transaction: transactions[index], deleteTx: deleteTx);
                  // Card(
                  //   // padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  //   // height: 100,
                  //   elevation: 5,
                  //   child: Row(
                  //     children: <Widget>[
                  //       Container(
                  //           margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 35.0),
                  //           padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  //           decoration: BoxDecoration(
                  //             border: Border.all(color: Theme.of(context).primaryColor, width: 1,),
                  //             borderRadius: BorderRadius.circular(20.0),
                  //           ),
                  //           child: Text(
                  //             '\$${transaction[index].amount.toStringAsFixed(2)}',
                  //             // '\$' + tx.amount.toString(),   //same line as before
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               color: Theme.of(context).primaryColor,
                  //             ),
                  //           )
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Text(transaction[index].title,
                  //             style: Theme.of(context).textTheme.title,
                  //             // TextStyle(
                  //             //   fontSize: 18,
                  //             //   fontWeight: FontWeight.bold,
                  //             // ),
                  //           ),
                  //           Text(
                  //             // tx.date.toString(),
                  //             DateFormat.yMMMd().format(transaction[index].date),
                  //             style: TextStyle(
                  //               color: Colors.grey,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // );
                // },
                // itemCount: transactions.length,
            );
      // ),

    // );
  }
}
