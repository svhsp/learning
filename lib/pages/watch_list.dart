import 'package:flutter/material.dart';

import '../models/stock_info.dart';
import '../services/stock_fetcher.dart';
import 'stock_search_delegate.dart';

class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
  static List<String> stockList = ['AAPL'];

  static void addStock(StockInfo stock) {
    stockList.add(stock.symbol);
  }
}

class _WatchlistPageState extends State<WatchlistPage> {
  void onStockSelected(StockInfo stock) {
    setState(() {
      WatchlistPage.addStock(stock);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Watchlist'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: StockSearchDelegate(onStockSelected: onStockSelected),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<StockInfo>>(
        future: StockFetcher.fetchStocks(WatchlistPage.stockList),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
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
                rows: stocksInfo
                    .map(
                      (stock) => DataRow(
                    cells: [
                      DataCell(Text(stock.symbol)),
                      DataCell(Text(stock.price.toStringAsFixed(2))),
                      DataCell(Text(stock.change.toStringAsFixed(2))),
                    ],
                  ),
                )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
