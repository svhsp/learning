import 'package:flutter/material.dart';

import '../main.dart';
import '../models/stock_info.dart';
import '../services/stock_fetcher.dart';
void main(){
  runApp(MyApp());
  Future<StockInfo> list = StockFetcher.fetchStocks(['AMAT']) as Future<StockInfo>;
  list.then((value) {
  print('got value');
  print(value);
  }).catchError((error) {
  print('Error');
  });
}
class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();

}

class _TestPageState extends State<TestPage> {
  late final List<StockInfo> _stocksInfo = [
    StockInfo(
    symbol: 'GOOG',
    name: 'Google Inc.',
    price: 2030.00,
    change: 15.00,
    ),
  ];
  @override
  void initState() {
    super.initState();

  }

  // void _fetchStocksInfo() async {
  //   final stocksInfo = await StockFetcher.fetchStocks(['GOOG', 'AAPL', 'TSLA','AMAT']);
  //   setState(() {
  //     _stocksInfo = stocksInfo;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Watchlist'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Symbol')),
            DataColumn(label: Text('Price')),
            DataColumn(label: Text('Change')),
          ],
          rows: _stocksInfo.map((stock) => DataRow(
            cells: [
              DataCell(Text('GOOG')),
              DataCell(Text('10000')),
              DataCell(Text('-69696969')),
            ],
          )).toList(),
        ),
      ),
    );
  }
}