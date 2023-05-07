import 'package:flutter/material.dart';
import 'package:learning/models/stock_info.dart';
import 'package:learning/services/stock_fetch.dart';
import 'package:learning/widgets/stock_card.dart';
import 'package:learning/pages/SearchTickerScreen.dart';
import 'StockSearchPage.dart';


bool isReady = false;

class StockListPage extends StatefulWidget {
  @override
  _StockListPageState createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {

  List<DataRow> rows = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    List<String> tickers = ['AAPL', 'GOOGL'];
    Future<List<StockInfo>> future = StockFetch.fetchStocks(tickers);
    future.then((value) {
      for (int i = 0; i < value.length; i++) {
        rows.add(
          DataRow(cells: <DataCell>[
            DataCell(Text(value[i].tickerName)),
            DataCell(Text(value[i].price)),
            DataCell(Text(value[i].percentChange)),
          ]),
        );
      }
      setState(() {
        isReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Watchlist',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final finalResult = await showSearch(
                    context: context,
                    delegate: SearchLocations(
                        Stocks: Stocks,
                        MainStocks: MainStocks));
                setState(() {
                  // selectedPlace = finalResult!;
                });

              },
            ),
          ],
        ),
        body: isReady
            ? Container(
          child: DataTable(
            columns: [
              DataColumn(label: Text('Ticker')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Percent Change')),
            ],
            rows: rows,
          ),
        )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
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
