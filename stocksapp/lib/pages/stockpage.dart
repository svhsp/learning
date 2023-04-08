import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Widgets/EmailVerificationScreen.dart';
import '../Resources/firebase_options.dart';
import '../Resources/firebase_constants.dart';
import 'main.dart';
import '../Widgets/stockclass.dart';
import '../Services/stockfetcher.dart';

StockFetcher stock = StockFetcher();
List<String> stocks = ["APPLE", "GAMESTOP", "SVB"];

class StocksPage extends StatefulWidget {
  const StocksPage({super.key, required this.title});
  final String title;

  @override
  State<StocksPage> createState() => _StocksPageState();
}

class _StocksPageState extends State<StocksPage> {
  Future _updateProfile() async {
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            DataTable(columns: const [
              DataColumn(label: Text("Symbol")),
              DataColumn(label: Text("Company")),
              DataColumn(label: Text("Price")),
              DataColumn(label: Text("Change")),
            ], rows: StockFetcher.buildTable(stock.fetchStocks(stocks)))
          ],
        ),
      ),
    );
  }
}
