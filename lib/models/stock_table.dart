import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stonks/services/global_var.dart';
import 'package:stonks/services/stock_fetcher.dart';

class MyDataTable extends StatelessWidget {
  final StockFetcher _stockFetcher = StockFetcher('G4UJ9ECYT8N1K1O6');

  @override
  Widget build(BuildContext context) {
    if (stockList == []) {
      return Center(
        child: Text('Your stock list is empty.'),
      );
    } else {
      return FutureBuilder(
        future: _stockFetcher.getStocks(stockList),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, String>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            List<DataRow> rows = snapshot.data!
                .map(
                  (Map<String, String> stock) =>
                  DataRow(
                    cells: <DataCell>[
                      DataCell(Text(stock['symbol']!)),
                      DataCell(Text(stock['price']!)),
                      DataCell(Text(stock['changePercent']!)),
                    ],
                  ),
            )
                .toList();
            return DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('Symbol')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Change Percent')),
              ],
              rows: rows,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Container();
          }
        },
      );
    }
  }
}





