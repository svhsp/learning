import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bosnia/models/stock.dart';
import 'package:flutter/material.dart';

class StockFetcher {

  static Future<List<Stock>> fetchStocks(List<String> tickers) async {
    List<Stock> returnValue = [];
    for (int i = 0; i < tickers.length; i++) {
      String tickerName = tickers[i];
      http.Response dataResponse = await http.get(Uri.parse(
          "https://finnhub.io/api/v1/quote?symbol=$tickerName&token=ch21rb1r01qroac5qu90ch21rb1r01qroac5qu9g"));
      Map data = jsonDecode(dataResponse.body);
      print(data);
      double percent = data["dp"];
      double price = data["c"];
      returnValue.add(Stock(
        ticker: tickers[i],
        price: price,
        percentageChange: percent,
      ));
    }
    return returnValue;
  }
}