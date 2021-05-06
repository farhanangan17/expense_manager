import 'package:expense_manager/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
// import 'user_transactions.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('dispose()');
    super.dispose();
  }

  void _submitData(){
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    // final enteredDate = _selectedDate.toString();

    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null || _amountController.text.isEmpty){
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
        // titleController.text,
        // double.parse(amountController.text)
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate){
      if (pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
        child: Container(
            height: 400,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            // padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom+ 10,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: TextStyle(
                          fontFamily: Theme.of(context).textTheme.title.fontFamily,
                        )
                    ),
                    controller: _titleController,
                    onSubmitted: (_) => _submitData(),
                    // onChanged: (val){
                    //   titleInput = val;
                    // },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Amount',
                      labelStyle: TextStyle(
                        fontFamily: Theme.of(context).textTheme.title.fontFamily,
                      )
                    ),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitData(),
                    // onChanged: (val){
                    //   amountInput = val;
                    // },
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                           _selectedDate == null
                               ? 'No Date Chosen'
                               : DateFormat.yMd().format(_selectedDate)
                        ),
                        Platform.isIOS
                        ? CupertinoButton(
                          onPressed: _presentDatePicker,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                        :TextButton(
                          onPressed: _presentDatePicker,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _submitData,
                      child: Text('Add Transaction',
                        style: Theme.of(context).textTheme.button,
                      ),
                  )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      // alignment: Alignment.topLeft,
                      // alignment: Alignment.topCenter,
                      primary: Theme.of(context).primaryColor, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: _submitData,
                    child: Text('Add Transaction',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                    // ElevatedButton(
                    //   style: ButtonTheme(
                    //     buttonColor: Colors.purple,
                    //   ),
                    //   onPressed: submitData,    //here after submitData => no ()
                    //   // (){
                    //   // addTx(
                    //   //     titleController.text,
                    //   //     double.parse(amountController.text)
                    //   // );
                    //   // print(titleInput);
                    //   // print(amountInput);
                    //   // },
                    //   child: Text('Add Transaction',
                    //     style: TextStyle(
                    //       color: Theme.of(context).textTheme.button.color,
                    //     ),
                    //   ),
                    // ),

                ],
              ),
            )
        ),
    );
  }
}
