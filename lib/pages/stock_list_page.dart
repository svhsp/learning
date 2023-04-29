import 'package:flutter/material.dart';
import 'package:learning/models/stock_info.dart';
import 'package:learning/services/stock_fetch.dart';
import 'package:learning/widgets/stock_card.dart';



// class StockListPage extends StatelessWidget {
//   const StockListPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text('Watchlist',
//             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//
//       ),
//       body: FutureBuilder<List<StockInfo>>(
//         future: StockFetch.fetchStocks(tickers),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             } else {
//               final stocks = snapshot.data!;
//               return ListView.builder(
//                 itemCount: stocks.length,
//                 itemBuilder: (context, index) {
//                   final StockInfo = stocks[index];
//                   return StockCard(
//                     tickerName: StockInfo.tickerName,
//                     price: StockInfo.price,
//                     percentChange: StockInfo.percentChange,
//                   );
//                 },
//               );
//             }
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:learning/models/stock_info.dart';
// import 'package:learning/services/stock_fetch.dart';
// import 'package:learning/widgets/stock_card.dart';
//
// List<String> tickers = ['AAPL', 'GOOGL', 'SPX'];
//
// class StockListPage extends StatefulWidget {
//   const StockListPage({Key? key}) : super(key: key);
//
//   @override
//   State<StockListPage> createState() => _StockListPageState();
// }
//
// class _StockListPageState extends State<StockListPage> {
//
//   void getStockInfo()
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.brown,
//         centerTitle: true,
//         elevation: 0
//         title: const Text('WatchList',
//
//       ),
//     ),
//     );
//   }
// }
