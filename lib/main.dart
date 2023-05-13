import 'package:flutter/material.dart';
import 'package:stonks/services/stock_fetcher.dart';
import 'models/signup.dart';
import 'models/login.dart';
import 'pages/home_page.dart';
import 'services/global_var.dart';
void main() {
  print(StockFetcher('https://finnhub.io/api/v1/search?q=AAPL&token=cgu3hqpr01qu2uq5p73gcgu3hqpr01qu2uq5p740'));
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