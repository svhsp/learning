import 'package:flutter/material.dart';
import 'package:stonks/models/stock_table.dart';
import 'package:stonks/services/stock_fetcher.dart';
import 'package:stonks/services/global_var.dart';

import '../services/search_delegate.dart';
import '../services/suggested_stocks_fetcher.dart';
class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}



class _WatchlistPageState extends State<WatchlistPage> {

  @override
  void initState() {
    super.initState();
    Future<List<Map<String, String>>> future = StockFetcher('https://finnhub.io/api/v1/search?q=AAPL&token=cgu3hqpr01qu2uq5p73gcgu3hqpr01qu2uq5p740').getStocks(stockList);
    future.then((value) {
      setState(() {
        isReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Watch List',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              setState(() {
                isReady = false;
              });

              final finalResult = await showSearch(context: context, delegate: searchDelegate(allStocks: allStocks, suggestedStocks: suggestedStocks));
              print(finalResult);
              setState(() {
                stockList.add(finalResult!);
                isReady = true;
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: isReady ? MyDataTable(): CircularProgressIndicator(),
        ),
      ),
    );
  }
}

final List <String> allStocks = [];

final List <String> suggestedStocks = [];

