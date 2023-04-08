import 'package:flutter/material.dart';
import 'package:login/pages/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/stock.dart';
import '../services/Services.dart';
import '../services/Stockfetch.dart';

class TickerScreen extends StatefulWidget {
  const TickerScreen({super.key});

  @override
  TickerScreenState createState() => new TickerScreenState();
}

// Stock class format: ticker name, price, change

class TickerScreenState extends State<TickerScreen> {
  List<DataColumn> columns = new List.empty(growable: true);
  List<DataRow> rows = List.empty(growable: true);
  late Future<List<Stock>> asyncStockData;

  Future<List<Stock>> fetch (List<String> links) async {
    //List<Stock> futureResult = await FetchServices.getStockData(links);
    return FetchServices.getStockData(links);
  }
  @override
  Widget build (BuildContext context) {
    List<String> links = List.empty(growable: true);
    links.insert(0, 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=GOOG&apikey=G4UJ9ECYT8N1K1O6');
    links.insert(1, 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=MSFT&apikey=G4UJ9ECYT8N1K1O6');
    links.insert(2, 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=AMD&apikey=G4UJ9ECYT8N1K1O6');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(appBar: AppBar(title: Row(children: [Text('Stocks', style: TextStyle(color: Colors.black),), IconButton(onPressed: () {

    }, icon: Icon(Icons.search, color: Colors.black,))],), backgroundColor: Colors.white70,), body:SafeArea(child: Column(children: [
      SizedBox(width: 1,  height: 30,),
      Column(
        children: <Widget>[
          SizedBox(width: 1, height: 10),
        FutureBuilder<List<Stock>>(
          future: fetch(links),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Stock> snapshotData = snapshot.data!;
              columns = [
                DataColumn(label: Text('Company Name')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Percent Change')),
              ];

              for (Stock stock in snapshotData) {
                rows.add(DataRow(cells: [
                  DataCell(Text(stock.ticker_name)),
                  DataCell(Text(stock.price)),
                  DataCell(Text(stock.change)),
                ]));
            }
              return DataTable(columns: columns, rows: rows);
            } else if (snapshot.hasError) {
              // Handle error case
              return Text('Error loading data');
            } else {
              // Async data is not yet ready, show a loading spinner
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        ],
      )
    ],),
    ),);
  }
}