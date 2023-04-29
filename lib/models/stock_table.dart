import 'package:flutter/material.dart';
import 'package:stonks/services/stock_fetcher.dart';

/*void main() {
  runApp(MyDataTable());
  Future<List<Map<String, String>>> future = StockFetcher('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=GOOG&apikey=G4UJ9ECYT8N1K1O6').getStocks();
  future.then((value) => print(value));
  }*/
class MyDataTable extends StatelessWidget {
  final Future<List<Map<String, String>>> future =
  StockFetcher('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=GOOG&apikey=G4UJ9ECYT8N1K1O6')
      .getStocks();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, String>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          List<DataRow> rows = snapshot.data!
              .map(
                (Map<String, String> stock) => DataRow(
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

