
import 'package:flutter/material.dart';
import 'package:learning/pages/stock_search.dart';
import '../models/stock_info.dart';
import '../widgets/reusable_widgets.dart';


class StockListPage extends StatefulWidget {
  List<StockInfo> listStockInfo = [];

  StockListPage({Key? key, required this.listStockInfo}) : super(key: key);

  @override
  State<StockListPage> createState() => _StockListPageState();
}

class _StockListPageState extends State<StockListPage> {

  List<String> all_stocks = ['AAPL'];
  List<String> suggested_stocks = ['AAPL'];

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          elevation: 0,
          centerTitle: true,
          title: Row(children: [
            const Text(
              "Watch List",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 200),
            IconButton(onPressed: () async {
              final finalResult = (await showSearch(
                  context: context,
                  delegate: StockSearch(all_stocks: all_stocks,
                      suggested_stocks: suggested_stocks),
              )
              );
              setState(() {

              });
            }, icon: Icon(Icons.search)),
          ])
        ),

        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringColor("EAFEEA"),
              hexStringColor("33B180"),
              hexStringColor("80CFB0")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Center(
            child: Column(
              children: [
                DataTable(columns: const [
                  DataColumn(label: Text("Symbol")),
                  DataColumn(label: Text("Price")),
                  DataColumn(label: Text("Change")),
                ],
                    rows: buildTable(widget.listStockInfo)
                ),
              ],
            ),
          ),
        )
    );
  }

  DataRow asDataRow(StockInfo stockInfo) {
    String percentageChange = stockInfo.percentageChange;
    late TextStyle style;

    if (stockInfo.percentageChange[0] == '-') {
      style = const TextStyle(fontWeight: FontWeight.bold, color: Colors.red);
    }
    else {
      style = const TextStyle(fontWeight: FontWeight.bold, color: Colors.green);
    }

    return DataRow(cells: [
      DataCell(Text(stockInfo.tickerName)),
      DataCell(Text('${stockInfo.price} USD')),
      DataCell(Text(percentageChange, style: style,)),
    ]);
  }

  List<DataRow> buildTable(List<StockInfo> stocks) {
    List<DataRow> returnValue = [];
    for (int i = 0; i < stocks.length; i++) {
      StockInfo cur = stocks[i];
      returnValue.add(asDataRow(cur));
    }
    return returnValue;
  }
}
