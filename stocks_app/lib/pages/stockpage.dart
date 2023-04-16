import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Widgets/EmailVerificationScreen.dart';
import '../Resources/firebase_options.dart';
import '../Resources/firebase_constants.dart';
import 'main.dart';
import '../Widgets/stockclass.dart';
import '../Services/stockfetcher.dart';
import '../Widgets/stockclass.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mongles/Widgets/stockclass.dart';
import 'package:async/async.dart';


class StocksPage extends StatefulWidget {
  const StocksPage({super.key, required this.title});
  final String title;

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  StockFetcher getData = StockFetcher();
  List<String> stockIds = ["APPL", "GAMESTOP", "SVB"];
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
              DataColumn(label: Text("Symbol")),
              DataColumn(label: Text("Price")),
              DataColumn(label: Text("Change")),
            ], rows: StockFetcher.buildTable(stocksID))
            print("hello world");
          ],
        ),
      ),
    );
  }
}

Future<List<Stocks>> getStock(List<String> ids) async {
  List<Stocks> output1 = [];
  for (int i = 0; i<ids.length; i++) {
    try{
      var url = Uri.parse(
          'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=${ids[i]}&apikey=G4UJ9ECYT8N1K1O6');
      var response = await http.get(url);
      Map data = jsonDecode(response.body);
      print(data);
      int percent = data['Global Quote']['10. change percent'];
      int price = data['Global Quote']['05. price'];
      output1.add(Stocks(ids[i], price, percent));
    }
    catch (e) {
      print('http call fail');
    }
  }
  return output1;
}
