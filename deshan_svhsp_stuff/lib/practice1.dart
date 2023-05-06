import 'package:flutter/material.dart';
import 'package:login/pages/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/services/DatabaseServices.dart';
import 'package:login/services/fetchServices.dart';

import '../models/stock.dart';

void main() async {
  List<String> links = List.empty(growable: true);
  links.add("http:/ /20.169.4.151:3000/AAPL");
  links.add("http://20.169.4.151:3000/MSFT");
  List<Stock> test = await FetchServices.getStockData(links);
  print("TEST: " + test.toString());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build (BuildContext context) {
    List<String> links = List.empty(growable: true);
    links.add("http://20.169.4.151:3000/AAPL");
    links.add("http://20.169.4.151:3000/MSFT");
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: FetchServices.getStockData(links),
          builder: (context, snapshot) {
            List<DataColumn> columns = [
              DataColumn(label: Text('Company Name')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Percent Change')),
            ];
            List<DataRow> rows = List.empty(growable: true);

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("error getting data: " + snapshot.error.toString());
            } else {
              List<Stock> data = snapshot.data!;

              for (Stock stock in data) {
                rows.add(DataRow(cells: [
                  DataCell(Text(stock.ticker_name!)),
                  DataCell(Text(stock.price!)),
                  DataCell(Text(stock.change!)),
                ]
                ));
              }

              return DataTable(columns: columns, rows: rows);
            }
          },
        ),
      ),
    );
  }
}