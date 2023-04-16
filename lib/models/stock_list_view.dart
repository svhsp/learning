import 'package:flutter/material.dart';
import 'package:stonks/models/stock_info.dart';
import 'package:stonks/services/stock_fetcher.dart';

class StockListView extends StatelessWidget {
  final StockFetcher stockFetcher;

  StockListView({required this.stockFetcher});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Stock>>(
      future: stockFetcher.getStocks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final stocks = snapshot.data!;
          return ListView.builder(
            itemCount: stocks.length,
            itemBuilder: (context, index) {
              final stock = stocks[index];
              return ListTile(
                title: Text(stock.symbol),
                subtitle: Text('${stock.name}, ${stock.change}%'),
                trailing: Text('\$${stock.price}'),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}