import 'dart:io';
import 'package:expense_manager/widgets/new_transaction.dart';
import 'package:expense_manager/widgets/transaction_list.dart';
// import 'package:expense_manager/widgets/user_transactions.dart';
import './models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/user_transactions.dart';
import 'package:flutter/services.dart';


void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

      // Platform.isIOS
        // ? CupertinoApp(
        //     title: 'Personal Expenses',
        //     theme: CupertinoThemeData(
        //
        //       primarySwatch: Colors.purple,
        //       errorColor: Colors.red,
        //       accentColor: Colors.amber,
        //       fontFamily: 'Quicksand',
        //       textTheme: ThemeData.light().textTheme.copyWith(
        //         title: TextStyle(
        //           fontFamily: 'OpenSans',
        //           fontWeight: FontWeight.bold,
        //           fontSize: 18,
        //         ),
        //         // bodyText1: TextStyle(
        //         //   fontFamily: 'OpenSans',
        //         //   // fontWeight: FontWeight.bold++,
        //         //   fontSize: 18,
        //         // ),
        //         button: TextStyle(
        //           color: Colors.white,
        //           fontFamily: 'OpenSans',
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //       appBarTheme: AppBarTheme(
        //         textTheme: ThemeData.light().textTheme.copyWith(
        //             title: TextStyle(
        //               fontFamily: 'OpenSans',
        //               fontSize: 20,
        //               fontWeight: FontWeight.bold,
        //             )
        //         ),
        //       ),
        //       visualDensity: VisualDensity.adaptivePlatformDensity,
        //     ),
        //     debugShowCheckedModeBanner: false,
        //     home: MyHomePage(),
        // )
    return MaterialApp(
          title: 'Personal Expenses',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            errorColor: Colors.red,
            accentColor: Colors.amber,
            fontFamily: 'Quicksand',
            textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(
                color: Colors.white,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
            ),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                  )
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {

  final List<Transaction> _userTransaction = [
    Transaction(
        id: 't1',
        title:'New Shoes',
        amount: 69.99,
        date: DateTime.now()
    ),
    Transaction(
        id: 't2',
        title:'Weekly Groceries',
        amount: 16.55,
        date: DateTime.now()
    ),
    Transaction(
        id: 't3',
        title:'Pizza',
        amount: 10.99,
        date: DateTime.now()
    ),
    Transaction(
        id: 't4',
        title:'Haircut',
        amount: 2.99,
        date: DateTime.now()
    ),
    Transaction(
        id: 't5',
        title:'Repair',
        amount: 15.00,
        date: DateTime.now()
    ),
    Transaction(
        id: 't6',
        title:'test1',
        amount: 10.99,
        date: DateTime.now()
    ),
    Transaction(
        id: 't7',
        title:'test2',
        amount: 10.99,
        date: DateTime.now()
    ),
  ];

  bool _showChart = false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    print(state);
  }

  @override
  dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransaction{
    return _userTransaction.where((tx){
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7))
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate,
        // date: DateTime.now()
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransaction(String id){
    setState(() {
      _userTransaction.removeWhere((tx){
        return tx.id == id;
      });
    });
  }

  void _startAddNewTransaction(BuildContext cntx){
    showModalBottomSheet(
      context: cntx,
      builder: (_){return NewTransaction(_addNewTransaction);}
          // GestureDetector(
          //   onTap: (){},
          //   child: behavior: HitTestBehavior.opaque,
          // );
    );
  }


  List<Widget> _buildLandscapeContent(
      Widget ldTxChartWidget,
      Widget txListWidget,
      ){
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Show Weekly Chart', style: Theme.of(context).textTheme.title,),
        Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val){
              setState(() {
                _showChart = val;
              });
            }
        ),
      ],
    ),
    _showChart ? ldTxChartWidget
        :txListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
    Widget txChartWidget,
    Widget txListWidget,
  ){
    return [txChartWidget, txListWidget];
  }



  @override
  Widget build(BuildContext context) {
    print('build() MyHomePageState');
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ?CupertinoNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          middle: Text('Personal Expenses'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => _startAddNewTransaction(context),
              )
            ],
          ),
        )
        :AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Container(
          padding: EdgeInsets.only(left: 30.0),
          alignment: Alignment.center,
          child: Text('Expense Manager',
            style: TextStyle(
              fontFamily: Theme.of(context).textTheme.title.fontFamily
              // color: Colors.purple
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
    );
    final txListWidget = Container(
        height: (
            mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top
        ) * 0.8,
        child: TransactionList(_userTransaction, _deleteTransaction)
    );
    final txChartWidget = Container(
        height: (
            mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top
        ) * 0.2,
        child: Chart(_recentTransaction)
    );
    final ldTxChartWidget = Container(
        height: (
            mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top
        ) * 0.5,
        child: Chart(_recentTransaction)
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment. start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // if(isLandscape)
            if (isLandscape) ..._buildLandscapeContent( ldTxChartWidget, txListWidget),
            if (!isLandscape) ..._buildPortraitContent(txChartWidget, txListWidget),
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            //   width: double.infinity,
            //   height: 100,
            //   child: Card(
            //     color: Colors.blue,
            //     child: Center(
            //       child: Text('BODY'),
            //     ),
            //     // Text('BODY')
            //     elevation: 5,
            //   ),
            // ),
          ],
          // Text(
          //   '$_counter',
          //   style: Theme.of(context).textTheme.headline4,
          // ),
          // ],
          // ),
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
        )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButton:
              Platform.isIOS
                ? Container()
                :FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () => _startAddNewTransaction(context),
                ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,


      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}