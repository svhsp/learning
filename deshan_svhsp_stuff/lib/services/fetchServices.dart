import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../models/result.dart';
import '../models/stock.dart';

class FetchServices {
  // Stock? globalQuote;
  //
  // FetchServices({this.globalQuote});
  //
  // FetchServices.fromJson(Map<String, dynamic> json) {
  //   globalQuote = json['Global Quote'] != null
  //       ? new Stock.fromJson(json['Global Quote'])
  //       : null;
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.globalQuote != null) {
  //     data['Global Quote'] = this.globalQuote!.toJson();
  //   }
  //   return data;
  // }

  static Future<List<Stock>> getStockData(List<String> links) async {
    // Stock? globalQuote;
    //
    // Map<String, dynamic> toJson() {
    //   final Map<String, dynamic> data = new Map<String, dynamic>();
    //   if (globalQuote != null) {
    //     data['Global Quote'] = globalQuote!.toJson();
    //   }
    //   return data;
    // }

    final dio = Dio();
    print('starting getdata function call with' + links.toString());
    List<Stock> stonks = List.empty(growable: true);

    for (String link in links) {
      final response = await dio.get(link);
      print("response: " + response.data.toString());

      // Map<String, dynamic> result = toJson();
      // var stock = Stock.fromJson(result);
      // print("STCOK: " + stock.toString());
      // stonks.add(stock);

      Map<String, dynamic> result = response.data;
      if (result != null && result != "") {
        Stock stock = new Stock(result['Global Quote']['01. symbol'], result['Global Quote']['05. price'], result['Global Quote']['10. change percent']);
        stonks.add(stock);
        print("get result: " + stock.toString());
      }
      // Stock stock = await Future.delayed(Duration(seconds: 2), () {
      //   return new Stock("i", "1", "2");
      // });
    }

    return stonks;
  }

  static Future<List<SearchResult>> getStockTickers (String query) async {
    String link = 'http://20.169.4.151:3000/query?keyword=' + query;
    final dio = Dio();
    List<SearchResult> results = List.empty(growable: true);

    final response = await dio.get(link);
    List<dynamic> mappedData = response.data;
    List<dynamic> test = List.empty(growable: false);

    try {
      print('RESULT: ' + mappedData.toString());
      for (Map i in mappedData[0]['bestMatches']) {
        if (i['1. symbol'].toString() != "" && i['2. name'].toString() != "" && i['1. symbol'].toString() != null && i['2. name'].toString() != null) {
          SearchResult temp = SearchResult(i['1. symbol'], i['2. name']);
          results.add(temp);
          print(temp.toString());
        } else {
          break;
        }
      }
    } on RangeError {
      print('cannot fetch tickers because results are nonexistent according to query');
      List<SearchResult> noPass = List.empty(growable: false);
      return noPass;
    }

    return results;
  }
}