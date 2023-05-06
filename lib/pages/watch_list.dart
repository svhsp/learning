import 'package:flutter/material.dart';

import '../models/stock_info.dart';
import '../services/stock_fetcher.dart';

class WatchlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Watchlist'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add your search functionality here
            },
          ),
        ],
      ),
      body: FutureBuilder<List<StockInfo>>(
        future: StockFetcher.fetchStocks(['GOOG', 'AAPL', 'TSLA']),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final stocksInfo = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Symbol')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Change')),
                ],
                rows: stocksInfo.map((stock) => DataRow(
                  cells: [
                    DataCell(Text(stock.symbol)),
                    DataCell(Text(stock.price.toStringAsFixed(2))),
                    DataCell(Text(stock.change.toStringAsFixed(2))),
                  ],
                )).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
// import 'package:flutter/material.dart';
//
// import '../models/stock_info.dart';
// import '../services/stock_fetcher.dart';
//
// void main() {
//   List<String> tickers = ['AAPL', 'GOOGL'];
//   runApp(WatchListPage());
// }
//
// bool isReady = false;
//
// class WatchListPage extends StatefulWidget {
//   @override
//   _WatchListPageState createState() => _WatchListPageState();
// }
//
// class _WatchListPageState extends State<WatchListPage> {
//   List<DataRow> rows = List.empty(growable: true);
//
//   @override
//   void initState() {
//     super.initState();
//     List<String> tickers = ['AAPL', 'GOOGL'];
//     Future<List<StockInfo>> future = StockFetcher.fetchStocks(tickers);
//     future.then((value) {
//       for (int i = 0; i < value.length; i++) {
//         rows.add(
//           DataRow(cells: <DataCell>[
//             DataCell(Text(value[i].name)),
//             DataCell(Text(value[i].price as String)),
//             DataCell(Text(value[i].change as String)),
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