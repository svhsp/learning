import 'package:firebase_demo1/models/stock_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

final String key = "I0YHBFLUAAA5GSUU";

class StockFetcher {
  Future<List<StockInfo>> fetchStocks(List<String> tickers) async {
    List<StockInfo> returnValue = [];
    for (int i = 0; i < tickers.length; i++) {
      String tickerName = tickers[i];

      try {
        http.Response dataResponse = await http.get(Uri.parse(
            "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=${tickerName}&apikey=${key}"));

        Map data = jsonDecode(dataResponse.body);

        if (data.containsKey("Note")) {
          print("Ratelimited");
        }
        else {
          String percentageChange = data["10. change percent"];

          returnValue.add(StockInfo(
              ticker: tickerName,
              price: double.parse(data["05. price"]),
              percentageChange: double.parse(
                  percentageChange.substring(0, percentageChange.length - 2))));
        }
      }
      catch (error) {
        print("ERROR FETCHING STOCK DATA: ${error.toString()}");
      }
    }
    return returnValue;
  }

  static DataRow asDataRow(StockInfo stockInfo, bool add, BuildContext context) {
    String percentageChange = '${stockInfo.percentageChange}%';
    late TextStyle style;
    var lastCell = DataCell(IconButton(icon: Icon(Icons.delete), onPressed: () {

      // do stuff

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Succesfully Deleted")
      ));
    }, color: Colors.red,));

    if (add) {
      lastCell = DataCell(IconButton(icon: Icon(Icons.add), onPressed: () {

        // do stuff

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Succesfully Added Ticker")
        ));
      }, color: Colors.green,));
    }

    if (stockInfo.percentageChange >= 0) {
      percentageChange = '+$percentageChange';
      style = const TextStyle(fontWeight: FontWeight.bold, color: Colors.green);
    }
    else {
      style = const TextStyle(fontWeight: FontWeight.bold, color: Colors.red);
    }

    return DataRow(cells: [
      DataCell(Text(stockInfo.ticker)),
      DataCell(Text('${stockInfo.price} USD')),
      DataCell(Text(percentageChange, style: style,)),
      lastCell,
    ]);
  }

  static List<DataRow> buildTable(List<StockInfo> stocks, bool add, BuildContext context) {
    List<DataRow> returnValue = [];

    for (int i = 0; i < stocks.length; i++) {
      StockInfo cur = stocks[i];
      returnValue.add(asDataRow(cur, add, context));
    }

    return returnValue;
  }
}