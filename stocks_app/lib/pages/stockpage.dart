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
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:mongles/Widgets/stockclass.dart';
import 'package:async/async.dart';
import '../Resources/search_services.dart';

List<String> stockIds = ["APPL", "TSLA", "AMZN"];

final List<String> allStocks = [
  "APPL", "TSLA", "SIVBQ", "JPM", "GOOG", "AMZN", "NVDA", "MSFT", "BRK.B", "GOOGL", "META", "UNH", "XOM"
];

final List<String> suggestedStocks = [
  "APPL", "TSLA", "SIVBQ", "JPM", "GOOG", "AMZN", "NVDA"
];
void main(){
  Future<List<Stocks>> result = getStock(stockIds);
  result.then((value) => print("done")).catchError((value) => print("amogues"));
}


class StocksPage extends StatefulWidget {
  const StocksPage({super.key, required this.title});
  final String title;

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  List<Stocks> stockList = [];
  List<Stocks> output69 = [];
  void getStockInfo(List<String> stockIds) {
    Future<List<Stocks>> tempList = getStock(stockIds);
    tempList.then((value) => {output69 = value}).catchError((value) => print("sussy baka"));
    setState(() {
      stockList = output69;
    });
  }
  @override
  Widget build(BuildContext context) {
    String selectedStock = '';
    getStockInfo(stockIds);
    Timer timer = Timer.periodic(Duration(seconds: 15), (timer) {
      getStockInfo(stockIds);
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            OutlinedButton.icon(
              label: Text('Search'),
              icon: Icon(Icons.search),
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.blue)
              ),
              onPressed: () async {
                final res = await showSearch(
                    context: context,
                    delegate: SearchStock(
                        stocks: allStocks, suggestedStocks: suggestedStocks
                    )
                );
                setState(() {
                  selectedStock = res;
                });
              },
            ),
            selectedStock == '' ? Container() :
            Expanded(
                child: ListView.builder(
                  itemCount: allStocks.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                        title: Text(allStocks[i])
                    );
                  },
                )
            ),

            DataTable(columns: const [
              DataColumn(label: Text("Symbol")),
              DataColumn(label: Text("Price")),
              DataColumn(label: Text("Change")),
            ], rows: buildTable(stockList)),
          ],
        ),
      ),
    );
  }
}

List<DataRow> buildTable(List<Stocks> stocks)  {
  List<DataRow> output = [];
  try {
    for (int i = 0; i < stocks.length; i++) {
      if (stocks[i].price == -69420){
        output.add(DataRow(cells: [
          DataCell(Row(children:[CircularProgressIndicator(),Text("  "+stocks[i].ticker_name, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))])),
          DataCell(Text("LOADING", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
          DataCell(Text("LOADING", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
        ]));
        continue;
      }
      output.add(dataRow(stocks[i]));
    }
  } catch(e){
     output.add(DataRow(cells: [
      DataCell(CircularProgressIndicator()),
      DataCell(Text("LOADING", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
      DataCell(Text("LOADING", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
    ]));
  }
  return output;
}

DataRow dataRow(Stocks stockInfo) {
    String percentageChange = '${stockInfo.change}%';
    late TextStyle stockStyle;

    if (stockInfo.change < 0) {
      percentageChange = '+$percentageChange';
      stockStyle =
      const TextStyle(fontWeight: FontWeight.bold, color: Colors.red);
    }
    else {
      stockStyle =
      const TextStyle(fontWeight: FontWeight.bold, color: Colors.green);
    }

    return DataRow(cells: [
      DataCell(Text(stockInfo.ticker_name)),
      DataCell(Text('${stockInfo.price} USD')),
      DataCell(Text(percentageChange, style: stockStyle,)),
    ]);
}


Future<List<Stocks>> getStock(List<String> ids) async {
  List<Stocks> output1 = [];
  for (int i = 0; i<ids.length; i++) {
    try{
      var url = Uri.parse(
          'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=${ids[i]}&apikey=G4UJ9ECYT8N1K1O6');
      var response = await http.get(url);
      Map data = jsonDecode(response.body);
      int percent = data['Global Quote']['10. change percent'];
      int price = data['Global Quote']['05. price'];
      output1.add(Stocks(ids[i], price, percent));
    }
    catch (e) {
      output1.add(Stocks(ids[i],-69420,-1));
    }
  }
  print(output1);
  return output1;
}

