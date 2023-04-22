import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../models/stock.dart';

class FetchServices {
  static Future<List<Stock>> getStockData(List<String> links) async {
    final dio = Dio();
    List<Stock> stocks = [];

    for (String link in links) {
      final response = await dio.get(link);
      Map<String, dynamic> result = response.data;
      Stock stock = Stock(
          result['Global Quote']['01. symbol'],
          result['Global Quote']['05. price'],
          result['Global Quote']['10. change percent']
      );

      stocks.add(stock);
    }

    return stocks;
  }
}