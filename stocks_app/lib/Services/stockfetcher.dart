import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:mongles/Widgets/stockclass.dart';
import 'package:async/async.dart';


class StockFetcher {
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
      DataCell(Text('${stockInfo.price} USD')),
      DataCell(Text(percentageChange, style: stockStyle,)),
    ]);
  }
}
