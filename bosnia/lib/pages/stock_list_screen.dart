import 'package:bosnia/models/stock.dart';
import 'package:flutter/material.dart';
import '../../reusable_widgets.dart';
import '../models/loading.dart';
import '../services/stock_fetcher.dart';
import '../services/stock_fetcher.dart';

StockFetcher stockFetcher = StockFetcher();
List<String> tickers = [
  "GOOGL",
  "TSLA",
  "AAPL",
];

bool isReady = false;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<DataRow> rows = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    Future<List<Stock>> future = StockFetcher.fetchStocks(tickers);
    future.then((value) {
      for (int i = 0; i < value.length; i++) {
        rows.add(
          DataRow(cells: <DataCell>[
            DataCell(Text(value[i].ticker)),
            DataCell(Text(value[i].price)),
            DataCell(
                value[i].percentageChange.contains('-')?
                Text(value[i].percentageChange, style: const TextStyle(color: Colors.red,)) :
                Text('+${value[i].percentageChange}', style: const TextStyle(color: Colors.green,))),
          ]),
        );
      }
      setState(() {
        isReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Watchlist',
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: isReady
            ? Container(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Ticker')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Percent Change')),
            ],
            rows: rows,
          ),
        )
            : Loading().load,
      ),
    );
  }

  DataRow asDataRow(Stock stockInfo) {
    String percentageChange = stockInfo.percentageChange;
    late TextStyle style;

    if (stockInfo.percentageChange[0] == '-') {
      style = const TextStyle(fontWeight: FontWeight.bold, color: Colors.red);
    }
    else {
      style = const TextStyle(fontWeight: FontWeight.bold, color: Colors.green);
    }

    return DataRow(cells: [
      DataCell(Text(stockInfo.ticker)),
      DataCell(Text('\$${stockInfo.price} USD')),
      DataCell(Text(percentageChange, style: style,)),
    ]);
  }

  List<DataRow> buildTable(List<Stock> stocks) {
    List<DataRow> returnValue = [];
    for (int i = 0; i < stocks.length; i++) {
      Stock cur = stocks[i];
      returnValue.add(asDataRow(cur));
    }
    return returnValue;
  }
}