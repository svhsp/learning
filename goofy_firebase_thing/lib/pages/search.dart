import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/stock_info.dart';
import '../services/stock_fetcher.dart';

final int updateTick = (60 / 5) as int;

StockFetcher stockFetcher = StockFetcher();

List<String> allTickers = [
  "GOOGL",
  "TSLA",
  "AAPL",
  "MSFT",
  "SAFE",
  "EAF",
  "XFOR",
];

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchKeywordController = TextEditingController();
  String searchKeyword = "";
  late FocusNode focusNode;

  int ticks = 0;

  List<StockInfo> lust = [];

  _SearchPageState() {
    initList();
  }


  List<String> search(String keyword) {
    List<String> baller = [];

    for (int i = 0; i < allTickers.length; i++) {
      if (allTickers[i].contains(keyword)) {
        baller.add(allTickers[i]);
      }
    }

    return baller;
  }

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        searchKeyword = searchKeywordController.text;
        ticks++;
        if (ticks >= updateTick) initList();
      });
    });
  }

  void initList() async {
    ticks = 0;
    lust = await stockFetcher.fetchStocks(search(searchKeyword));
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
        actions: [],
        leading: IconButton(icon: Icon(Icons.close, color: Colors.white,), onPressed: () {
          Navigator.of(context).pop();
        },),
        title: const Text(
          "Search",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),

      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              TextFormField(
                controller: searchKeywordController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Search stocks...",
                ),
              ),
              Divider(),
              DataTable(columns: const [
                DataColumn(label: Text("Symbol")),
                DataColumn(label: Text("Price")),
                DataColumn(label: Text("Change")),
                DataColumn(label: Text("Action")),
              ], rows: StockFetcher.buildTable(lust, true, context)),
              loading(),
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