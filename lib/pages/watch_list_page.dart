import 'package:flutter/material.dart';
import 'package:stonks/services/stock_fetcher.dart';
import 'package:stonks/models/appbar.dart';
import 'package:stonks/models/stock_list_view.dart';

class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  final StockFetcher stockFetcher = StockFetcher('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=GOOG&apikey=G4UJ9ECYT8N1K1O6');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: StockListView(stockFetcher: stockFetcher),

      ),
    );
  }
}


