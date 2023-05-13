import 'package:flutter/material.dart';
import 'package:login/pages/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/services/DatabaseServices.dart';

import '../models/stock.dart';
import '../query.dart';
import '../services/fetchServices.dart';

class loggedInID {
  String id;
  loggedInID(this.id);
}

class TickerScreen extends StatefulWidget {
  const TickerScreen({super.key});

  @override
  TickerScreenState createState() => new TickerScreenState();
}

// Stock class format: ticker name, price, change

class TickerScreenState extends State<TickerScreen> {
  List<String> searchResults = [
    "AMD",
    "APPL",
    "MSFT",
    "M",
    "GOOG",
  ];

  List<String> searchSuggestions = [
    "AMD",
    "APPL",
    "MSFT",
    "M",
    "GOOG",
  ];
  List<String> alreadyPutIn = List.empty(growable: true);
  List<DataColumn> columns = new List.empty(growable: true);
  List<DataRow> rows = List.empty(growable: true);
  late Future<List<Stock>> asyncStockData;

  Future<List<Stock>> fetch (String userId) async {
    print("I WENT IN THE FUNCTIONOISDHFIOU");
    // get url
    // get stocks
    // piece links
    DatabaseServices a = new DatabaseServices();
    String mainPiece = await a.getUrl();
    List<String> links = List.empty(growable: true);
    List<String>? stonks = await a.getUserPreferences(userId);
    print("STONKS: " + stonks.toString());

    for (String link in stonks!) {
      links.add(mainPiece + link + "&apikey=YNGXUGMXQ93PLTF6");
    }

    return FetchServices.getStockData(links).catchError((error) => Text("Failed to collect stock data because of: " + error));
  }

  @override

  @override
  Widget build (BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as loggedInID;
    DatabaseServices a = new DatabaseServices();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(appBar: AppBar(title:
    Row(children: [
      Text('Stocks', style: TextStyle(color: Colors.black),), SizedBox(width: 260,), IconButton(onPressed: () async {
        final finalResult = await showSearch(context: context, delegate: SearchLocations(allCaliforniaPlaces: searchResults, allCaliforniaSuggestions: searchSuggestions));
        List<String>? stockList = await a.getUserPreferences(args.id);
        setState(() {
          FirebaseFirestore.instance.collection("preferences").doc(args.id).delete().onError((error, stackTrace) => print("error updating document"));
          stockList!.add(finalResult.toString());
          FirebaseFirestore.instance.collection("preferences").doc(args.id).set({"stocks" : stockList});
        });
    }, icon: Icon(Icons.search, color: Colors.black,)),
    ],), backgroundColor: Colors.white70,), body:SafeArea(child: Column(children: [
      SizedBox(width: 1,  height: 30,),
      Column(
        children: <Widget>[
          SizedBox(width: 1, height: 10),
        FutureBuilder<List<Stock>>(
          future: fetch(args.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Stock> snapshotData = snapshot.data!;
              columns = [
                DataColumn(label: Text('Company Name')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Percent Change')),
              ];

              for (Stock stock in snapshotData) {
                bool flag = false;

                for (int i = 0; i < rows.length; i++) {
                  DataRow row =  rows[i];
                  print("CURRENT DATAROW" + row.toString());

                }

                print("contents: " + alreadyPutIn.toString());
                print("flag: " + alreadyPutIn.contains(stock.ticker_name!).toString());

                if (!alreadyPutIn.contains(stock.ticker_name!)) {
                  alreadyPutIn.add(stock.ticker_name!);
                  print("PASED: " + stock.ticker_name!);
                  rows.add(DataRow(cells: [
                    DataCell(Text(stock.ticker_name!)),
                    DataCell(Text(stock.price!)),
                    DataCell(Text(stock.change!)),
                  ]));
                }
            }
              return Column(
                children: <Widget>[
                  Center(
                      child: Container(
                        height: 500,
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(columns: columns, rows: rows),
                            ),
                          ],
                        ),
                      ),

                  ),

            ],
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              // Handle error case
              return Text('Error loading data, remember that you can have a maximum of 5 API calls in a minute.');
            } else {
              // Async data is not yet ready, show a loading spinner
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        ],
      )
    ],),
    ),);
  }
}