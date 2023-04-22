import 'package:flutter/material.dart';

class StockCard extends StatelessWidget {
  final String tickerName;

  final String price;
  final String percentChange;

  const StockCard({
    Key? key,
    required this.tickerName,

    required this.price,
    required this.percentChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Text(
          tickerName.toUpperCase(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text(tickerName),
        subtitle: Text(
          'Price: ${price}, Change: ${percentChange}',
        ),
      ),
    );
  }
}
