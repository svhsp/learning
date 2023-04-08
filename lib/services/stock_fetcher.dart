/*
import 'package:stonks/models/stock_info.dart';

final List<Stock> stocks = [
  Stock(symbol: 'AAPL', price: 144.54, change: 0.89, changePercentage: 0.62),
  Stock(symbol: 'MSFT', price: 262.59, change: -1.27, changePercentage: -0.48),
  Stock(symbol: 'GOOG', price: 2145.79, change: -12.87, changePercentage: -0.6),
  Stock(symbol: 'TSLA', price: 697.6, change: -5.27, changePercentage: -0.75),
  Stock(symbol: 'AMZN', price: 3320.79, change: -11.56, changePercentage: -0.35),
];

class StockFetcher {
  Future<List<Stock>> fetchStock(List<String> tickers) {
    return Future.value(stocks);
  }
}*/

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/stock_info.dart';

class StockFetcher {
  static const String _baseUrl = 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=AAPL&apikey=G4UJ9ECYT8N1K1O6';


  static Future<List<StockInfo>> fetchStocks() async {
    final response = await http.get(Uri.parse(_baseUrl));
    final Map<String, dynamic> data = json.decode(response.body);
    final Map<String, dynamic> stockData = data['Global Quote'];
    return [
      StockInfo(
        symbol: stockData['01. symbol'],
        name: '',
        price: double.parse(stockData['05. price']),
        change: double.parse(stockData['09. change']),
      ),
    ];
  }
}