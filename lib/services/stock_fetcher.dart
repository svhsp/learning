import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/stock_info.dart';

class StockFetcher {
  static const String _baseUrl1 = 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=';
  static const String _baseUrl2  = '&apikey=G4UJ9ECYT8N1K1O6';

  static Future<List<StockInfo>> fetchStocks(List<String> companies) async {
    final List<StockInfo> stocksInfo = [];

    for (String company in companies) {
      final response = await http.get(Uri.parse(_baseUrl1 + company + _baseUrl2));
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('Global Quote')) {
        final stockData = data['Global Quote'];

        stocksInfo.add(
          StockInfo(
            symbol: stockData['01. symbol'],
            name: '',
            price: double.parse(stockData['05. price']),
            change: double.parse(stockData['09. change']),
          ),
        );
      }
    }

    return stocksInfo;
  }
}
