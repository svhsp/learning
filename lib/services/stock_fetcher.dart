import 'dart:convert';
import 'package:flutter/animation.dart';
import 'package:http/http.dart' as http;
import 'package:stonks/models/stock_info.dart';
import 'package:stonks/services/global_var.dart';

class StockFetcher {

  final String _apiKey;
  StockFetcher(this._apiKey);

  Future<List<Map<String, String>>> getStocks(List<String> symbols) async {
    List<Map<String, String>> stocks = [];
    print(symbols);
    for (String symbol in symbols) {
      String _baseUrl =
          'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$_apiKey';
      print('URL: ' + _baseUrl);
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        Map<String, dynamic> globalQuote = data['Global Quote'];
        String symbol = globalQuote['01. symbol'];
        String price = globalQuote['05. price'];
        String changePercent = globalQuote['10. change percent'];

        final stock = {
          'symbol': symbol,
          'price': price,
          'changePercent': changePercent,
        };
        stocks.add(stock);
      } else {
        throw Exception('Failed to load stocks');
      }
    }

    return stocks;
  }
}





