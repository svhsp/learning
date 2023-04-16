import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock.dart';

class StockManager {
  Future<List<Stock>> fetchStocks(List<String> tickers) async {
    List<Stock> listStocks = [];
    for (String ticker in tickers) {
      http.Response response = await http.get(Uri.parse(
          'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$ticker&apikey=G4UJ9ECYT8N1K1O6'));
      Map<String, dynamic> data = jsonDecode(response.body);
      Map<String, dynamic> quote = data['Global Quote'];
      double currentPrice = double.parse(quote['05. price']);
      String changePercentInString = quote['10. change percent'].toString();
      double changePercent = double.parse(changePercentInString.substring(
          0, changePercentInString.length - 1)); // remove "%" at the end.
      listStocks.add(Stock(
          ticker: quote['01. symbol'],
          price: currentPrice,
          changeInPercentage: changePercent));
    }
    return listStocks;
  }
}
