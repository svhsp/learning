import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mongles/Widgets/stockclass.dart';

class StockFetcher {
  List<Stocks> fetchStocks(List<String> tickers) {
    List<Stocks> output = [];
    for (int i = 0; i < tickers.length; i++) {
      output.add(Stocks(tickers[i], "appleREAL", 69, 39));
    }
    return output;
  }
  static List<DataRow> buildTable(List<Stocks> stocks) {
    List<DataRow> output = [];

    for (int i = 0; i < stocks.length; i++) {
      Stocks newStock = stocks[i];
      output.add(asDataRow(newStock));
    }

    return output;
  }
  static DataRow asDataRow(Stocks stockInfo) {
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
      DataCell(Text(stockInfo.company)),
      DataCell(Text('${stockInfo.price} USD')),
      DataCell(Text(percentageChange, style: stockStyle,)),
    ]);
  }
}
