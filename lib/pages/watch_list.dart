import 'package:flutter/material.dart';

import '../models/stock_info.dart';
import '../services/stock_fetcher.dart';

class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  List<StockInfo> _stocksInfo = [];

  @override
  void initState() {
    super.initState();
    _fetchStocksInfo();
  }

  void _fetchStocksInfo() async {
    final stocksInfo = await StockFetcher.fetchStocks(['GOOG', 'AAPL', 'TSLA']);
    setState(() {
      _stocksInfo = stocksInfo;
    });
  }

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
              DataCell(Text(stock.symbol)),
              DataCell(Text(stock.price.toStringAsFixed(2))),
              DataCell(Text(stock.change.toStringAsFixed(2))),
            ],
          )).toList(),
        ),
      ),
    );
  }
}