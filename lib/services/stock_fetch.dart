import 'package:learning/models/stock_info.dart';
import 'package:flutter/material.dart';
import 'package:learning/pages/stock_list_page.dart';
import 'package:flutter/material.dart';
import 'package:learning/pages/verification.dart';
import 'package:learning/pages/stock_list_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/pages/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learning/pages/createacc.dart';
import 'package:learning/pages/verification.dart';
import 'package:learning/pages/login.dart';

class StockFetch {
  static Future<List<Stock>> fetchStocks() async {
    return [
      Stock(
        tickerName: 'AAPL',
        company: 'Apple Inc.',
        price: 133.5,
        change: -0.2,
      ),
      Stock(
        tickerName: 'GOOG',
        company: 'Alphabet Inc.',
        price: 2213.5,
        change: 0.5,
      ),
      Stock(
        tickerName: 'MSFT',
        company: 'Microsoft Corporation',
        price: 249.9,
        change: -0.1,
      ),
      Stock(
        tickerName: 'TSLA',
        company: 'Tesla Inc.',
        price: 708.0,
        change: 0.8,
      ),
    ];
  }
}