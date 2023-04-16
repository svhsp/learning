import 'package:bosnia/models/stock.dart';
import 'package:flutter/material.dart';
import '../../reusable_widgets.dart';
import '../services/stock_fetcher.dart';

StockFetcher stockFetcher = StockFetcher();
List<String> tickers = [
  "GOOGL",
  "TSLA",
  "AAPL",
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Stock> listStockInfo = [];
  List<Stock> initialList = [];
  StockFetcher stockFetcher = StockFetcher();

  void getStockInfo(List<String> tickers) async {
    initialList = await stockFetcher.fetchStocks(tickers);
    setState(() {
      listStockInfo = initialList;
    });
    print('setState');
  }

  @override
  void initState() {
    getStockInfo(tickers);
    print('yes');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Watch List",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        body: Container(
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          child: Center(
            child: Column(
              children: [
                DataTable(columns: const [
                  DataColumn(label: Text("Symbol")),
                  DataColumn(label: Text("Price")),
                  DataColumn(label: Text("Change")),
                ],
                    rows: buildTable(listStockInfo)
                ),
              ],
            ),
          ),
        )
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
      DataCell(Text('${stockInfo.price} USD')),
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