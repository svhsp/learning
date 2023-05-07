import 'package:learning/models/stock_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learning/models/stock_info.dart';
import 'package:learning/services/stock_fetch.dart';
import 'package:learning/widgets/stock_card.dart';
import 'package:learning/pages/SearchTickerScreen.dart';

/*
class fetch_name{
  List<StockInfo> returnValue = [];
  static Future<List<StockInfo>> fetchStockName(List<String> tickers) async {
    String url = 'https://finnhub.io/api/v1/search?q=$tickers&token=cgu3hqpr01qu2uq5p73gcgu3hqpr01qu2uq5p740';
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = json.decode(response.body);
    print(data);
  }
}
*/

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> searchStock(String ticker) async {
  String url = 'https://finnhub.io/api/v1/search?q=$ticker&token=cgu3hqpr01qu2uq5p73gcgu3hqpr01qu2uq5p740';
  http.Response response = await http.get(Uri.parse(url));

  if(response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    if(data.containsKey('result')) {
      List<dynamic> results = data['result'];
      if(results.isNotEmpty) {
        Map<String, dynamic> stock = {
          'description': results[0]['description'],
          'displaySymbol': results[0]['displaySymbol'],
          'symbol': results[0]['symbol'],
          'type': results[0]['type'],
        };
        return stock;
      }
    }
  }

  return null;
}
