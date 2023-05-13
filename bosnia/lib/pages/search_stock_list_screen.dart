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
    Future<Stock> future = StockFetcher.fetchStock(selectedStock);
    future.then((value) {
      selectedStockValue.add(
        DataRow(cells: <DataCell>[
          DataCell(Text(value.ticker)),
          DataCell(Text(value.price)),
          DataCell(
              value.percentageChange.contains('-')?
              Text('${value.percentageChange}%', style: const TextStyle(color: Colors.red,)) :
              Text('+${value.percentageChange}%', style: const TextStyle(color: Colors.green,))),
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
        actions: [
          OutlinedButton.icon(
            label: const Text(''),
            icon: const Icon(Icons.search),
            style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: const BorderSide(color: Colors.blueAccent)
            ),
            onPressed: () async {
              isReady = false;
              final res = await showSearch(
                context: context,
                delegate: SearchStocks(),
              );
              setState(() {
                selectedStock = res;
                getStock();
              });
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child:Column(
          children: [
            selectedStock == '' ?
            Expanded(
              child: Container(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Ticker')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Percent Change')),
                ],
                rows: selectedStockValue,
              ),
            ),
            ) :
            Expanded(
              child: Container(
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
            ),
          ],
        ),
      ),
    );
  }
}