import 'package:firebase_demo1/pages/stock_search_screen.dart';
import 'package:firebase_demo1/pages/stock_sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/stock_info.dart';
import '../services/stock_fetcher.dart';

final int updateTick = (60 / 5) as int;

StockFetcher stockFetcher = StockFetcher();
List<String> tickers = [
  "GOOGL",
  "TSLA",
  "AAPL",
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<StockInfo> lust = [];

  int ticks = 0;

  _HomePageState() {
    initList();
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        ticks++;
        if (ticks >= updateTick) initList();
      });
    });
  }

  void initList() async {
    ticks = 0;
    lust = await stockFetcher.fetchStocks(tickers);
  }

  Widget loading() {
    if (lust.isEmpty || lust == []) {
      return CircularProgressIndicator(color: Colors.green,);
    }
    return Divider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: () {
            // search btuon
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  SearchPage()));
          },),
        ],
        leading: IconButton(icon: Icon(Icons.exit_to_app, color: Colors.white,), onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pop();
        },),
        title: const Text(
          "Watch List",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),

      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              DataTable(columns: const [
                DataColumn(label: Text("Symbol")),
                DataColumn(label: Text("Price")),
                DataColumn(label: Text("Change")),
                DataColumn(label: Text("Action")),
              ], rows: StockFetcher.buildTable(lust, false, context)),
              loading(),
              Text("\n\nTip: Press the search button on the top right to add ticker", style: TextStyle(
                color: Colors.grey,
              ),)
            ],
          ),
        )
      ),
    );
  }
}

// child: ElevatedButton(
//   onPressed: () {
//     FirebaseAuth.instance.signOut().then((value) {
//       print("Signed out");
//       Navigator.pushNamed(context, '/');
//     });
//   },
//   child: const Text('Logout'),
// ),


//Sign Out Button
// body: Center(
// child: ElevatedButton(
//   onPressed: () {
//     FirebaseAuth.instance.signOut().then((value) {
//       print("Signed out");
//       Navigator.pushNamed(context, '/');
//     });
//   },
//   style: ButtonStyle(
//     backgroundColor: MaterialStateProperty.resolveWith((states) {
//       if (states.contains(MaterialState.pressed)) {
//         return Colors.black26;
//       }
//       return Colors.white;
//     }),
//     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//       RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(30),
//       ),
//     ),
//   ),
//   child: const Text('Log Out',
//     style: TextStyle(
//         color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
//   ),
// ),
// child: ,