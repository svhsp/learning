import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/stock_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<StockInfo> stocks = [StockInfo(symbol: 'AAPL', name: 'Apple Inc.', price: 125.90, change: 1.54),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Watchlist'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: const <DataColumn>[
            DataColumn(label: Text('Symbol')),
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Price')),
            DataColumn(label: Text('Change')),
            DataColumn(label: Text('')),
          ],
          rows: stocks
              .map((stock) => DataRow(
            cells: <DataCell>[
              DataCell(Text(stock.symbol)),
              DataCell(Text(stock.name)),
              DataCell(Text(stock.price.toStringAsFixed(2))),
              DataCell(Text(stock.change.toStringAsFixed(2))),

            ],
          ))
              .toList(),
        ),
      ),
    );
  }
}
