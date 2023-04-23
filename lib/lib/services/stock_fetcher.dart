import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock_info.dart';

class StockFetcher {
  static const String _baseUrl1 = 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=';
  static const String _baseUrl2  = '&apikey=G4UJ9ECYT8N1K1O6';
  static Future<List<StockInfo>> fetchStocks(String a) async {
    final response = await http.get(Uri.parse(_baseUrl1 + a + _baseUrl2));
    final Map<String, dynamic> data = json.decode(response.body);
    final stockData = data['Global Quote'];
    return [
      StockInfo(
        symbol: stockData['01. symbol'],
        name: '',
        price: double.parse(stockData['05. price']),
        change: double.parse(stockData['09. change']),
      )
    ];
  }
}