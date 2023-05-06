// import 'package:flutter/material.dart';
// import 'package:login/pages/profileScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:login/services/DatabaseServices.dart';
//
// import '../models/stock.dart';
// import '../services/fetchServices.dart';
//
// class loggedInID {
//   String id;
//   loggedInID(this.id);
// }
//
// class TickerScreen extends StatefulWidget {
//   const TickerScreen({super.key});
//
//   @override
//   TickerScreenState createState() => new TickerScreenState();
// }
//
// // Stock class format: ticker name, price, change
//
// class TickerScreenState extends State<TickerScreen> {
//   List<DataColumn> columns = new List.empty(growable: true);
//   List<DataRow> rows = List.empty(growable: true);
//   late Future<List<Stock>> asyncStockData;
//
//   Future<List<Stock>> fetch (String userId) async {
//     // get url
//     // get stocks
//     // piece links
//     List<Stock> data;
//     DatabaseServices a = new DatabaseServices();
//     String mainPiece = await a.getUrl();
//     List<String> links = List.empty(growable: true);
//     List<String>? stonks = await a.getUserPreferences(userId);
//
//     for (String link in stonks!) {
//       links.add(mainPiece + link + "&apikey=YNGXUGMXQ93PLTF6");
//     }
//
//     return FetchServices.getStockData(links).catchError((error) => Text("Failed to collect stock data because of: " + error)).then((value) {
//       data = value;
//
//       columns = [
//         DataColumn(label: Text('Company Name')),
//         DataColumn(label: Text('Price')),
//         DataColumn(label: Text('Percent Change')),
//       ];
//
//       for (Stock stock in data) {
//         bool flag = false;
//
//         print("flag: " + flag.toString());
//
//         if (flag == false) {
//           rows.add(DataRow(cells: [
//             DataCell(Text(stock.ticker_name)),
//             DataCell(Text(stock.price)),
//             DataCell(Text(stock.change)),
//           ]));
//         };
//       }
//     });
//
//     return ;
//   }
//   @override
//   Widget build (BuildContext context) {
//     final args = ModalRoute.of(context)!.settings.arguments as loggedInID;
//     DatabaseServices a = new DatabaseServices();
//
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//
//     return Scaffold(appBar: AppBar(title: Row(children: [Text('Stocks', style: TextStyle(color: Colors.black),), IconButton(onPressed: () {
//
//     }, icon: Icon(Icons.search, color: Colors.black,))],), backgroundColor: Colors.white70,), body:SafeArea(child: Column(children: [
//       SizedBox(width: 1,  height: 30,),
//     ],),
//       fetch(args.id);
//     ),);
//   }
// }