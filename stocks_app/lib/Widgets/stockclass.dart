import 'package:yahoofin/yahoofin.dart';
import 'dart:async';
import 'package:dio/dio.dart';
class Stocks {
  String ticker_name;
  int price;
  int change;
  Stocks(this.ticker_name, this.price, this.change);
}