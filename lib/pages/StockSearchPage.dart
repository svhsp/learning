import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'SearchTickerScreen.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedPlace = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Delegate',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          selectedPlace == ''
              ? Container()
              : Container(
            padding:
            EdgeInsets.symmetric(horizontal: 35.0, vertical: 15.0),
            color: Colors.deepOrange,
            child: Text(
              selectedPlace,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Stocks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(Stocks[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final List<String> Stocks = [
  'hi',
  'a'
];

final List<String> MainStocks = [
  'hi',
  'asdf'
];