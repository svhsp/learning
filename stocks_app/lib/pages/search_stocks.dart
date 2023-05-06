import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Widgets/EmailVerificationScreen.dart';
import '../Resources/firebase_options.dart';
import '../Resources/firebase_constants.dart';
import 'emailandpassword sign in.dart';
import 'stockpage.dart';
import 'main.dart';
import 'demo_future_builder.dart';


class search_page extends StatefulWidget {
  const search_page({super.key, required this.title});
  final String title;
  @override
  State<search_page> createState() => _search();
}

final List<String> allStocks = [
  "APPL", "TSLA", "SIVBQ", "JPM", "GOOG", "AMZN", "NVDA"
];

class _search extends State<search_page>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            DataTable(columns: const [
              DataColumn(label: Text("Stock")),
            ], rows: buildListView(allStocks)),
          ],
        ),
      ),
    );
  }
}

List<DataRow> buildListView(List<dynamic> stocks)  {
  List<DataRow> output = [];
  try {
    for (int i = 0; i < stocks.length; i++) {
      output.add(DataRow(cells: [
        DataCell(Text(stocks[i], style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black))),
      ]));
    }
  } catch(e){
    output.add(DataRow(cells: [
      DataCell(Text("ERROR", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
    ]));
  }
  return output;
}