import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../models/stock.dart';

class FetchServices {
  static Future<List<Stock>> getStockData(List<String> links) async {
    final dio = Dio();
    print('starting getdata function call with' + links.toString());
    List<Stock> stonks = List.empty(growable: true);

    for (String link in links) {
      final response = await dio.get(link);
      print("response: " + response.data.toString());

      Map<String, dynamic> result = response.data;

      if (result != null && result != "") {
        Stock stock = new Stock(result['Global Quote']['01. symbol'], result['Global Quote']['05. price'], result['Global Quote']['10. change percent']);
        stonks.add(stock);
        print("get result: " + stock.toString());
      }
      // add try catch, check if the stock thingy is empty,
      // Stock stock = await Future.delayed(Duration(seconds: 2), () {
      //   return new Stock("test", "1", "2");
      // });
    }

    return stonks;
  }
}