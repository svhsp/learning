import 'package:flutter/material.dart';

import '../models/stock_info.dart';
import '../services/stock_fetcher.dart';

class WatchlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Watchlist'),
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