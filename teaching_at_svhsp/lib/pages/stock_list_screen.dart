import 'package:flutter/material.dart';
import 'package:teaching_at_svhsp/pages/search_ticker_screen.dart';

import '../models/stock.dart';
import '../widgets/stock_list.dart';

class StockListScreen extends StatelessWidget {
  static const String pageName = "/show_stock_price";
  final List<Stock> stockList;

  StockListScreen({Key? key, required this.stockList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Watch',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      showSearch(
                        context: context,
                        delegate: SearchTickerScreen(),
                      );
                    },
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              StockList(
                stocks: stockList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
