import 'package:flutter/material.dart';
import 'package:learning/models/stock_info.dart';
import 'package:learning/services/stock_fetch.dart';
import 'package:learning/widgets/stock_card.dart';
import 'package:learning/models/stock_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> main() async {
  // http.Response dataResponse = await http.get(Uri.parse(
  //     "http://20.169.4.151:3000/AAPL"));
  // Map data = jsonDecode(dataResponse.body);
  // print(data);
  runApp(MaterialApp());
}

class DataFetch {
  static Future<Map<String, dynamic>> fetchData() async {
    // try{
    http.Response dataResponse =
        await http.get(Uri.parse("http://20.169.4.151:3000/AAPL"));

    final data = jsonDecode(dataResponse.body);
    var result = StockThingy.fromJson(data);
    print(data);
    double percent = data["change percent"];
    double price = data["05. price"];
    return data;
    print(result);

    // }
    // catch (e) {
    //   print("error with stockFetch");
    // }
  }
}

class StockThingy {
  GlobalQuote? globalQuote;

  StockThingy({this.globalQuote});

  StockThingy.fromJson(Map<String, dynamic> json) {
    globalQuote = json['Global Quote'] != null
        ? new GlobalQuote.fromJson(json['Global Quote'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.globalQuote != null) {
      data['Global Quote'] = this.globalQuote!.toJson();
    }
    return data;
  }
}

class GlobalQuote {
  String? s01Symbol;
  String? s05Price;
  String? s10ChangePercent;

  GlobalQuote(
      {this.s01Symbol,
      this.s05Price,
      this.s10ChangePercent});

  GlobalQuote.fromJson(Map<String, dynamic> json) {
    s01Symbol = json['01. symbol'];
    s05Price = json['05. price'];
    s10ChangePercent = json['10. change percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['01. symbol'] = this.s01Symbol;
    data['05. price'] = this.s05Price;
    data['10. change percent'] = this.s10ChangePercent;
    return data;
  }
}
// class Page extends StatelessWidget {
//   const Page({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Future Builder Demo'),
//         ),
//         body: FutureBuilder<List<StockInfo>>(
//         future: ,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('Error: ${snapshot.error}'),
//               );
//             } else {
//
//             }
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     )
//     );
//   }
// }
//
//
