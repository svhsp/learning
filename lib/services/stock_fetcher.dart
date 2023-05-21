// import 'dart:math';
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../models/stock_info.dart';
//
// class StockFetcher {
//
//   Future<List<StockInfo>> fetchStocks(List<String> tickers) async {
//     List<StockInfo> returnValue = [];
//     for (int i = 0; i < tickers.length; i++) {
//       try {
//         var url = Uri.parse(
//             'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=${tickers[i]}&apikey=G4UJ9ECYT8N1K1O6');
//         var response = await http.get(url);
//         Map data = jsonDecode(response.body);
//         print(data);
//         String percent = data['Global Quote']['10. change percent'];
//         String price = data['Global Quote']['05. price'];
//         returnValue.add(StockInfo(
//             tickerName: tickers[i], percentageChange: percent, price: price));}
//       catch (e) {
//         print('http call fail');
//       }
//     }
//     return returnValue;
//   }
//
//   Future<List<StockInfo>> searchStocks(String query) async {
//     List<StockInfo> returnValue = [];
//     try {
//       var url = Uri.parse(
//           'https://finnhub.io/api/v1/search?q=' + query +
//               '&token=cgu3hqpr01qu2uq5p73gcgu3hqpr01qu2uq5p740');
//       var response = await http.get(url);
//       Map data = jsonDecode(response.body);
//
//       for (int i = 0; i < min(data['result'].length, 3); i++) {
//         returnValue.add(StockInfo.search(
//             tickerName: data['result'][i]['symbol'],
//             companyName: data['result'][i]['description']));
//       }
//     } catch (e) {
//       print('http call fail');
//     }
//     return returnValue;
//   }
//
// }