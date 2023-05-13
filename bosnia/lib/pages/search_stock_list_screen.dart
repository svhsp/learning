import 'package:bosnia/pages/search_delegate_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/loading.dart';
import '../models/stock.dart';
import '../services/stock_fetcher.dart';

bool isReady = false;

class StockSearch extends StatefulWidget {

  const StockSearch({Key? key}) : super(key: key);

  @override
  State<StockSearch> createState() =>
      _StockSearchState();
}

class _StockSearchState extends State<StockSearch> {
  String selectedStock = '';
  late List<DataRow> selectedStockValue = [];

  void getStock() async {
    selectedStockValue.clear();
    Future<Stock> future = StockFetcher.fetchStock(selectedStock);
    future.then((value) {
      selectedStockValue.add(
          DataRow(cells: <DataCell>[
            DataCell(Text(value.ticker)),
            DataCell(Text(value.price)),
            DataCell(
                value.percentageChange.contains('-')?
                Text(value.percentageChange, style: const TextStyle(color: Colors.red,)) :
                Text('+${value.percentageChange}', style: const TextStyle(color: Colors.green,))),
          ]));
      setState(() {
        isReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Search',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          OutlinedButton.icon(
            label: Text('Search'),
            icon: Icon(Icons.search),
            style: OutlinedButton.styleFrom(
                primary: Colors.deepOrange,
                side: BorderSide(color: Colors.blue)
            ),
            onPressed: () async {
              final res = await showSearch(
                  context: context,
                  delegate: SearchLocations(
                      locations: stocks, suggestedLocations: suggestedStocks
                  )
              );
              setState(() {
                selectedStock = res;
                getStock();
              });
            },
          ),
          selectedStock == '' ? Container() :
          Container(
            child: isReady
            ? Container(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Ticker')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Percent Change')),
              ],
              rows: selectedStockValue,
              ),
            )
                : Loading().load,
          ),
          Expanded(
              child: ListView.builder(
                itemCount: stocks.length,
                itemBuilder: (context, idx) {
                  return ListTile(
                      title: Text(stocks[idx])
                  );
                },
              ))
        ],
      ),
    );
  }
}


final List<String> stocks = [
  "AAPL",
  "AMZN",
  "GOOGL",
  "KO",
  "MSFT",
  "TSLA",
];


final List<String> suggestedStocks = [
  "AAPL",
  "GOOGL",
  "TSLA",
];