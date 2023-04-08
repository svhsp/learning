import 'package:flutter/material.dart';
import 'package:stonks/models/stock_info.dart';
import 'package:stonks/services/stock_fetcher.dart';


class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Watchlist'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ListView.builder(
          itemCount: stockList.length,
          itemBuilder: (context, index) {
            final stock = stockList[index];
            return ListTile(
              title: Text(stock.symbol),
              subtitle: Text('${stock.price.toStringAsFixed(2)} (${stock.change.toStringAsFixed(2)})'),
            );
          },
        )

      ),
    );
  }
}


