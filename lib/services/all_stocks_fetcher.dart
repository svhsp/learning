import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:stonks/models/stock_info.dart';

class AllStockFetcher {
  static const String _baseUrl =
      'https://finnhub.io/api/v1/search';
  final String _apiKey;

  AllStockFetcher(this._apiKey);

  Future<List<Stock>> lookAllSymbol(String ticker) async {
    List<Stock> stocks = [];

    http.Response response = await http.get(Uri.parse(
        'https://finnhub.io/api/v1/search?q=$ticker&token=cgu3hqpr01qu2uq5p73gcgu3hqpr01qu2uq5p740'));
    Map<String, dynamic> data = jsonDecode(response.body);
    int itemCount = data['count'];

    for (int i = 0; i < itemCount; i++) {
      Map<String, dynamic> item = data['result'][i];
      stocks.add(Stock.Symbol(item['symbol'], item['description']));
    }
    return stocks;
  }

}



