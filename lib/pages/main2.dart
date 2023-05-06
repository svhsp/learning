import 'package:flutter/material.dart';
import 'package:learning/models/stock_info.dart';
import 'package:learning/services/stock_fetch.dart';
import 'package:learning/widgets/stock_card.dart';



// void main(){
//   List<String> tickers = ['AAPL', 'GOOGL'];
//   runApp(StockListPage());
//
// }

// bool isReady = false;
//
// class StockListPage extends StatefulWidget {
//   @override
//   _StockListPageState createState() => _StockListPageState();
// }
//
// class _StockListPageState extends State<StockListPage> {
//
//   List<DataRow> rows = List.empty(growable: true);
//
//   @override
//   void initState() {
//     super.initState();
//     List<String> tickers = ['AAPL', 'GOOGL'];
//     Future<List<StockInfo>> future = StockFetch.fetchStocks(tickers);
//     future.then((value) {
//       for (int i = 0; i < value.length; i++) {
//         rows.add(
//           DataRow(cells: <DataCell>[
//             DataCell(Text(value[i].tickerName)),
//             DataCell(Text(value[i].price)),
//             DataCell(Text(value[i].percentChange)),
//           ]),
//         );
//       }
//       setState(() {
//         isReady = true;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Watchlist',
//             style: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: isReady
//             ? Container(
//           child: DataTable(
//             columns: [
//               DataColumn(label: Text('Ticker')),
//               DataColumn(label: Text('Price')),
//               DataColumn(label: Text('Percent Change')),
//             ],
//             rows: rows,
//           ),
//         )
//             : Center(child: CircularProgressIndicator()),
//       ),
//     );
//   }
// }