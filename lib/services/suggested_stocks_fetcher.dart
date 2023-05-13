import 'dart:convert';
import 'dart:core';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:stonks/models/stock_info.dart';
import 'package:stonks/services/global_var.dart';

class StockNameFetcher {
  static const String _baseUrl =
      'https://finnhub.io/api/v1/search';
  final String _apiKey;

  StockNameFetcher(this._apiKey);

  Future<List<Stock>> lookupSymbol(String ticker) async {
    List<Stock> stocks = [];

    http.Response response = await http.get(Uri.parse(
        'https://finnhub.io/api/v1/search?q=$ticker&token=cgu3hqpr01qu2uq5p73gcgu3hqpr01qu2uq5p740'));
        Map<String, dynamic> data = jsonDecode(response.body);
        int itemCount = min(data['result'].length, 3);

        for (int i = 0; i < itemCount; i++) {
      Map<String, dynamic> item = data['result'][i];
      // logger.log(Level.info, data);
      stocks.add(Stock.Symbol(item['symbol'], item['description']));
    }
        print("STONKS: " + stocks.toString());
    return stocks;
  }

}



