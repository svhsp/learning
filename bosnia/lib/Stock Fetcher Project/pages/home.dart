import 'package:bosnia/Stock Fetcher Project/models/stock.dart';
import 'package:flutter/material.dart';
import '../services/stock_fetcher.dart';

StockFetcher stockFetcher = StockFetcher();
List<String> tickers = [
  "GOOGL",
  "TSLA",
  "AAPL",
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Watch List",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),

      body: Center(
        child: Column(
          children: [
            DataTable(columns: const [
              DataColumn(label: Text("Symbol")),
              DataColumn(label: Text("Price")),
              DataColumn(label: Text("Change")),
            ], rows: StockFetcher.getTableRows())
          ],
        ),
      ),
    );
  }
}