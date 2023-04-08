import 'package:flutter/material.dart';
import 'package:learning/models/stock_info.dart';
import 'package:learning/services/stock_fetch.dart';
import 'package:learning/widgets/stock_card.dart';

class StockListPage extends StatelessWidget {
  const StockListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Watchlist',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),

      ),
      body: Center(
        child: FutureBuilder<List<Stock>>(
          future: StockFetch.fetchStocks(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final stocks = snapshot.data!;
                return ListView.builder(
                  itemCount: stocks.length,
                  itemBuilder: (context, index) {
                    final stock = stocks[index];
                    return StockCard(
                      tickerName: stock.tickerName,
                      company: stock.company,
                      price: stock.price,
                      change: stock.change,
                    );
                  },
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}