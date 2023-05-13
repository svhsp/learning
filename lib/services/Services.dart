import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../models/stock.dart';

class StockManager {
  final logger = Logger();

  Future<List<Stock>> fetchStocks(List<String> tickers) async {
    List<Stock> listStocks = [];
    if (tickers.isEmpty) return Future.value(listStocks);
    for (String ticker in tickers) {
      http.Response response = await http.get(Uri.parse(
          'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$ticker&apikey=G4UJ9ECYT8N1K1O6'));
      Map<String, dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> quote = data['Global Quote'];
      double currentPrice = double.parse(quote['05. price']);
      String changePercentInString = quote['10. change percent'].toString();
      double changePercent = double.parse(changePercentInString.substring(
          0, changePercentInString.length - 1)); // remove "%" at the end.
      listStocks.add(Stock(quote['01. symbol'], currentPrice, changePercent));
    }
    return listStocks;
  }

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
    return stocks;
  }
}