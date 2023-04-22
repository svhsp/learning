import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../services/services.dart';

class TickerScreen extends StatefulWidget {
  const TickerScreen({super.key});

  @override
  _TickerScreenState createState() => _TickerScreenState();
}

class _TickerScreenState extends State<TickerScreen> {
  List<DataColumn> columns = [];
  List<DataRow> rows = [];
  late Future<List<Stock>> asyncStockData;

  @override
  void initState() {
    super.initState();
    asyncStockData = _fetchStockData();
  }

  Future<List<Stock>> _fetchStockData() async {
    List<String> links = [      'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=GOOG&apikey=G4UJ9ECYT8N1K1O6',      'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=MSFT&apikey=G4UJ9ECYT8N1K1O6',      'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=AMD&apikey=G4UJ9ECYT8N1K1O6',    ];
    return FetchServices.getStockData(links);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Stocks',
              style: TextStyle(color: Colors.black),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.white70,
      ),
      body: SafeArea(
        child: FutureBuilder<List<Stock>>(
          future: asyncStockData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Stock> snapshotData = snapshot.data!;
              columns = [
                DataColumn(label: Text('Company Name')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Percent Change')),
              ];

              for (Stock stock in snapshotData) {
                rows.add(DataRow(cells: [
                  DataCell(Text(stock.ticker_name)),
                  DataCell(Text(stock.price)),
                  DataCell(Text(stock.change)),
                ]));
              }
              return DataTable(columns: columns, rows: rows);
            } else if (snapshot.hasError) {
              return Text('Error loading data');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
