import 'package:flutter/material.dart';
import 'package:stonks/models/stock_table.dart';
import 'package:stonks/services/stock_fetcher.dart';
import 'package:stonks/models/appbar.dart';
import 'package:stonks/services/global_var.dart';
class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}



class _WatchlistPageState extends State<WatchlistPage> {
  Future<List<Map<String, String>>> future = StockFetcher('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=GOOG&apikey=G4UJ9ECYT8N1K1O6').getStocks();

  @override
  void initState() {
    super.initState();
    future.then((value) {
      setState(() {
        isReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Container(
          child: isReady ? MyDataTable(): CircularProgressIndicator(),
        ),
      ),
    );
  }
}



