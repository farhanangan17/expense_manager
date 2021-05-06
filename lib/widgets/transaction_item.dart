import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {

  final Transaction transaction;
  final Function deleteTx;

  const TransactionItem({
    // this key only apply when it is a root level widget like here for the transaction list this widget is the root level one.
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);



  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    // TODO: implement initState
    const availableColors = [
      Colors.red,
      Colors.purple,
      Colors.amber,
      Colors.blue
    ];
    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${widget.transaction.amount.toStringAsFixed(2)}',),
            ),
          ),
        ),
        title: mediaQuery.size.width > 200
            ? Text(
                widget.transaction.title,
                style: Theme.of(context).textTheme.title,
            ): Container(),
        subtitle: mediaQuery.size.width > 200
            ? Text(
                DateFormat.yMMMd().format(widget.transaction.date),
                style: TextStyle(fontFamily: Theme.of(context).textTheme.title.fontFamily),
            ): Container(),
        trailing: mediaQuery.size.width > 400
            ? TextButton.icon(
          icon: Icon(Icons.delete,
            color: Theme.of(context).errorColor,
          ),
          label: Text('Delete',
            style: TextStyle(
              color: Theme.of(context).errorColor,
            ),
          ),
          // color: Theme.of(context).errorColor,
          onPressed: () => widget.deleteTx(widget.transaction.id),
        ) :IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => widget.deleteTx(widget.transaction.id),
        ),
      ),
    );
  }
}
