import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bosnia/Stock Fetcher Project/models/stock.dart';
import 'package:flutter/material.dart';

class StockFetcher {

  static List<DataRow> returnValue = [];

  static DataRow asDataRow(Stock stockInfo) {
    String percentageChange = '${stockInfo.percentageChange}%';
    late TextStyle style;

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
    ]);
  }

  static List<DataRow> getTableRows() {
    buildTable();
    return returnValue;
  }

  static Future<void> buildTable() async {
    final appleurl = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=AAPL&apikey=G4UJ9ECYT8N1K1O6";
    final apple = await http.get(appleurl as Uri);
    final teslaurl = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=TSLA&apikey=G4UJ9ECYT8N1K1O6";
    final tesla = await http.get(teslaurl as Uri);
    final googleurl = "https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=GOOGL&apikey=G4UJ9ECYT8N1K1O6";
    final google = await http.get(googleurl as Uri);
    List<Stock> stocks = [];
    if (apple.statusCode == 200) {
      Iterable json = jsonDecode(apple.body);
      stocks.add(json.map((stock) => Stock.fromJson(stock)) as Stock);
    } else {
      throw Exception("Error fetching stocks");
    }
    if (tesla.statusCode == 200) {
      Iterable json = jsonDecode(tesla.body);
      stocks.add(json.map((stock) => Stock.fromJson(stock)) as Stock);
    } else {
      throw Exception("Error fetching stocks");
    }
    if (google.statusCode == 200) {
      Iterable json = jsonDecode(google.body);
      stocks.add(json.map((stock) => Stock.fromJson(stock)) as Stock);
    } else {
      throw Exception("Error fetching stocks");
    }

    for (int i = 0; i < stocks.length; i++) {
      Stock cur = stocks[i];
      returnValue.add(asDataRow(cur));
    }
  }
}