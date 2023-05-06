import 'package:flutter/material.dart';
import 'package:login/pages/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/services/DatabaseServices.dart';

import '../models/stock.dart';
import '../services/fetchServices.dart';

void main() async {
  runApp(Ticker());
}

class Ticker extends StatefulWidget {
  const Ticker({Key? key}) : super(key: key);

  @override
  State<Ticker> createState() => _TickerState();
}

class _TickerState extends State<Ticker> {
  List<DataColumn> columns = [
    DataColumn(label: Text("Company Name")),
    DataColumn(label: Text("Price")),
    DataColumn(label: Text("Change")),
  ];

  List<DataRow> rowsMaker (List<Stock> row) {
    print("I WENT IN THE ROW MAKER FUNCTION");
    List<DataRow> rows = List.empty(growable: true);
    for (Stock stonk in row) {
      print("TICKER NAME: " + stonk.ticker_name!);
      rows.add(DataRow(cells: [
        DataCell(Text(stonk.ticker_name!)),
    DataCell(Text(stonk.price!)),
    DataCell(Text(stonk.change!)),
    ]));
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    List<String> links = List.empty(growable: true);
    List<Stock> results = List.empty(growable: true);
    links.add("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=AAPL&apikey=YNGXUGMXQ93PLTF6");
    links.add("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=AMD&apikey=YNGXUGMXQ93PLTF6");
    links.add("https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=GOOG&apikey=YNGXUGMXQ93PLTF6");
    FetchServices.getStockData(links).catchError((error) => print("something went wrong: " + error)).then((value) { results = value; print('RESULTS AFTER SETTING: ' + results.toString()
    );}).whenComplete(() => print("I AM DONE"));
    List<DataRow> rows = List.empty(growable: true);
    rows = rowsMaker(results);
    print("FIRST ROW: " + rows.toString());
    return MaterialApp(
      home: Scaffold(
        body: Container(
            child: DataTable(columns: columns, rows: rows),
          ),
      ),
    );
  }
}
