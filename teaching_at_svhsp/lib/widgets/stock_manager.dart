import 'dart:convert';

import 'package:http/http.dart' as http;

class StockManager {
  Future<void> fetchStocks(List<String> tickers) async {
    http.Response response = await http.get(Uri.parse(
        'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=AAPL&apikey=G4UJ9ECYT8N1K1O6'));
    Map data = jsonDecode(response.body);
    print(data);
  }
}
