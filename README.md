# i_love_svhsp

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.




THIS IS ANDREWS CODE





import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
class StockMarketSimulator extends StatefulWidget {
  const StockMarketSimulator({Key? key}) : super(key: key);
  @override
  _StockMarketSimulatorState createState() => _StockMarketSimulatorState();

}

class _StockMarketSimulatorState extends State<StockMarketSimulator> {
  String selectedStock = 'AAPL';
  double currentPrice = 0;
  List<double> historicalPrices = [];

  @override
  void initState() {
    super.initState();
    fetchStockData();
  }

  Future<void> fetchStockData() async {
    Response response = (await get('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=AAPL&apikey=G4UJ9ECYT8N1K1O6')) as http.Response;

    Map data = jsonDecode(response.body); // this requires import dart:convert
    String symbol = data['01. symbol'];
    print('printing symbol...');
    print (symbol);
    // Make an API call to retrieve the current stock price and historical data
    // Update the currentPrice and historicalPrices variables with the retrieved data
  }

  void buyStock() {
    fetchStockData();
    // Add the selected stock to the user's portfolio and update the portfolio UI
  }

  void sellStock() {
    // Remove the selected stock from the user's portfolio and update the portfolio UI
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Market Simulator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Stock: $selectedStock',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Current Price: ${currentPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
            Container(
              height: 200,
              width: 300,
              // Display a graph that shows the historical prices of the selected stock
              // Use the historicalPrices variable to populate the graph data
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: buyStock,

                  child: Text('Buy'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: sellStock,
                  child: Text('Sell'),
                ),
              ],
            ),
            // Display the user's portfolio
            // Use a ListView or a DataTable to display the portfolio data
          ],
        ),
      ),
    );
  }
}
