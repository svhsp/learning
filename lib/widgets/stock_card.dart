import 'package:flutter/material.dart';

class StockCard extends StatelessWidget {
  final String tickerName;
  final String company;
  final double price;
  final double change;

  const StockCard({
    Key? key,
    required this.tickerName,
    required this.company,
    required this.price,
    required this.change,
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
        title: Text(company),
        subtitle: Text(
          'Price: ${price.toStringAsFixed(2)}, Change: ${change.toStringAsFixed(2)}',
        ),
      ),
    );
  }
}
