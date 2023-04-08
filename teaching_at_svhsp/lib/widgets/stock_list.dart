import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/stock.dart';

class StockList extends StatelessWidget {
  final List<Stock> stocks;
  const StockList({Key? key, required this.stocks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final stock = stocks[index];

        return ListTile(
          contentPadding: EdgeInsets.all(5),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                stock.ticker,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                stock.ticker,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          trailing: Column(
            children: <Widget>[
              Text(
                "${stock.price}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey[400],
        );
      },
      itemCount: stocks.length,
    );
  }
}
