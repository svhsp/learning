import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/stock_info.dart';

class StockFetcher {

  Future<List<StockInfo>> fetchStocks(List<String> tickers) async {
    List<StockInfo> returnValue = [];
    for (int i = 0; i < tickers.length; i++) {

      try{
        var url = Uri.parse(
            'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=${tickers[i]}&apikey=G4UJ9ECYT8N1K1O6');
        var response = await http.get(url);
        Map data = jsonDecode(response.body);
        print(data);
        String percent = data['Global Quote']['10. change percent'];
        String price = data['Global Quote']['05. price'];
        returnValue.add(StockInfo(tickerName: tickers[i], percentageChange: percent, price: price));
      }
      catch (e) {
        print('http call fail');
      }
    }
    return returnValue;
  }
}
