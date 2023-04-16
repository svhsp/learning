import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bosnia/Stock Fetcher Project/models/stock.dart';
import 'package:flutter/material.dart';

class StockFetcher {
  Future<List<Stock>> fetchStocks(List<String> tickers) async {
    List<Stock> returnValue = [];
    for (int i = 0; i < tickers.length; i++) {

      try{
        var url = Uri.parse(
            'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=${tickers[i]}&apikey=G4UJ9ECYT8N1K1O6');
        var response = await http.get(url);
        Map data = jsonDecode(response.body);
        print(data);
        String percent = data['Global Quote']['10. change percent'];
        String price = data['Global Quote']['05. price'];
        returnValue.add(Stock(ticker: tickers[i], percentageChange: percent, price: price));
      }
      catch (e) {
        print('http call fail');
      }
    }
    return returnValue;
  }
}