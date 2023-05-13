import 'dart:convert';
import 'dart:math';

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

  static Future<Stock> fetchStock(String ticker) async {
    Stock ret;
    http.Response dataResponse = await http.get(Uri.parse(
        "https://finnhub.io/api/v1/quote?symbol=$ticker&token=ch21rb1r01qroac5qu90ch21rb1r01qroac5qu9g"));
    Map data = jsonDecode(dataResponse.body);
    print(data);
    double percent = data["dp"];
    double price = data["c"];
    ret = Stock(
      ticker: ticker,
      price: price,
      percentageChange: percent,
    );
    return ret;
  }

  Future<List<String>> searchStock(String ticker) async {
    List<String> stocks = [];
    http.Response response = await http.get(Uri.parse(
        'https://finnhub.io/api/v1/search?q=$ticker&token=cgu3hqpr01qu2uq5p73gcgu3hqpr01qu2uq5p740'));
    Map<String, dynamic> data = jsonDecode(response.body);
    int itemCount = min(data['result'].length, 3);
    for (int i = 0; i < itemCount; i++) {
      Map<String, dynamic> item = data['result'][i];
      // logger.log(Level.info, data);
      stocks.add("${item['symbol']}");
    }
    return stocks;
  }
}