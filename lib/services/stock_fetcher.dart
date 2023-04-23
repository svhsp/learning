import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/stock_info.dart';

class StockFetcher {
  static const String _baseUrl = 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=AAPL&apikey=G4UJ9ECYT8N1K1O6';


  static Future<List<StockInfo>> fetchStocks() async {
    final response = await http.get(Uri.parse(_baseUrl + 'stocks'));
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => StockInfo(
      symbol: json['symbol'],
      name: json['name'],
      price: json['price'],
      change: json['change'],
    )).toList();
  }
}