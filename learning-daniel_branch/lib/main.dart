import 'package:flutter/material.dart';
import 'search_page.dart';
import 'watchlist_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Viewer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WatchListPage(),
        '/search': (context) => SearchPage(),
      },
    );
  }
}
