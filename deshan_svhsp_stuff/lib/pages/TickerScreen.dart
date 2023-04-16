import 'package:flutter/material.dart';
import 'package:login/pages/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/services/DatabaseServices.dart';

import '../models/stock.dart';
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
  List<DataColumn> columns = new List.empty(growable: true);
  List<DataRow> rows = List.empty(growable: true);
  late Future<List<Stock>> asyncStockData;

  Future<List<Stock>> fetch (String userId) async {
    // get url
    // get stocks
    // piece links
    DatabaseServices a = new DatabaseServices();
    String mainPiece = await a.getUrl();
    List<String> links = List.empty(growable: true);
    List<String>? stonks = await a.getUserPreferences(userId);

    for (String link in stonks!) {
      links.add(mainPiece + link + "&apikey=YNGXUGMXQ93PLTF6");
    }

    return FetchServices.getStockData(links);
  }
  @override
  Widget build (BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as loggedInID;
    DatabaseServices a = new DatabaseServices();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(appBar: AppBar(title: Row(children: [Text('Stocks', style: TextStyle(color: Colors.black),), IconButton(onPressed: () {

    }, icon: Icon(Icons.search, color: Colors.black,))],), backgroundColor: Colors.white70,), body:SafeArea(child: Column(children: [
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
                rows.add(DataRow(cells: [
                  DataCell(Text(stock.ticker_name)),
                  DataCell(Text(stock.price)),
                  DataCell(Text(stock.change)),
                ]));
            }
              return Column(
                children: <Widget>[
                  Center(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(columns: columns, rows: rows),
                        ),
                        ],
                    ),
                  ),a

            ],
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              // Handle error case
              return Text('Error loading data, remember that you can have a maximum of 5 stocks.');
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