import 'package:flutter/material.dart';
import 'package:stonks/services/stock_fetcher.dart';
import 'models/signup.dart';
import 'models/login.dart';
import 'pages/home_page.dart';
void main() {
  StockFetcher('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=GOOG&apikey=G4UJ9ECYT8N1K1O6');
  runApp(MaterialApp(
    title: 'Flutter Login Demo',
    initialRoute: '/',
    routes: {
      '/': (context) => HomePage(),
      '/signup': (context) => SignUpPage(),
      '/signin': (context) => SignInPage(),
    },
  ));
}