import 'package:flutter/material.dart';

import '../models/stock.dart';

class StockList extends StatelessWidget {
  final List<Stock> stocks;
  const StockList({Key? key, required this.stocks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      horizontalMargin: 10,
      columnSpacing: 100,
      columns: const [
        DataColumn(
          label: Text("Symbol"),
        ),
        DataColumn(
          label: Text("Price"),
        ),
        DataColumn(
          label: Text("Change"),
        ),
      ],
      rows: buildTable(stocks),
    );
  }

  DataRow buildRow(Stock stock) {
    double percentageChange = stock.changeInPercentage;
    late TextStyle style;

    if (percentageChange < 0) {
      style = const TextStyle(fontWeight: FontWeight.bold, color: Colors.red);
    } else {
      style = const TextStyle(fontWeight: FontWeight.bold, color: Colors.green);
    }

    return DataRow(cells: [
      DataCell(Text(stock.ticker)),
      DataCell(Text('${stock.price}')),
      DataCell(Text(
        "$percentageChange%",
        style: style,
      )),
    ]);
  }

  List<DataRow> buildTable(List<Stock> stocks) {
    List<DataRow> returnValue = [];
    for (int i = 0; i < stocks.length; i++) {
      Stock cur = stocks[i];
      returnValue.add(buildRow(cur));
    }
    return returnValue;
  }
}
