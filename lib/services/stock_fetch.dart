import 'package:learning/models/stock_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StockFetch {
  static Future<List<StockInfo>> fetchStocks(List<String> tickers) async {
    List<StockInfo> returnValue = [];
    for (int i = 0; i < tickers.length; i++) {
      String tickerName = tickers[i];
      // try{
        http.Response dataResponse = await http.get(Uri.parse(
            "https://finnhub.io/api/v1/quote?symbol=$tickerName&token=ch21rb1r01qroac5qu90ch21rb1r01qroac5qu9g"));

        Map data = jsonDecode(dataResponse.body);
        print(data);
        double percent = data["dp"];
        double price = data["c"];
        returnValue.add(StockInfo(
          tickerName: tickers[i],
          price: price,
          percentChange: percent,
        ));

      // }
      // catch (e) {
      //   print("error with stockFetch");
      // }

    }
    return returnValue;
  }
}
