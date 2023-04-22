import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stonks/models/stock_info.dart';
import 'package:stonks/services/global_var.dart';
class StockFetcher {
  static const String _baseUrl =
      'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=GOOG&apikey=G4UJ9ECYT8N1K1O6';
  final String _apiKey;

  StockFetcher(this._apiKey);

  Future<List<Stock>> getStocks() async {
    final response = await http.get(Uri.parse(
        '$_baseUrl${'SYMBOL_SEARCH'}&keywords=GOOG&apikey=$_apiKey'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);

      Map<String, dynamic> globalQuote = data['Global Quote'];
      symbol = globalQuote['01. symbol'];
      price = globalQuote['05. price'];
      changePercent = globalQuote['10. change percent'];
      print('Symbol: $symbol');
      print('Price: $price');
      print('Change Percent: $changePercent');


      final stocks = [  {    'symbol': symbol,    'price': price,    'changePercent': changePercent,  },];
      print(stocks);

      if (stocks != null) {
        return stocks
            .map((json) => Stock.fromJson(json))
            .toList(growable: false);
      }
      else {
        throw Exception('Failed to load stocks');
      }
    } else {
      throw Exception('Failed to load stocks');
    }
  }

}


