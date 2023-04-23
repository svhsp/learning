import 'package:StockWatchListApp/pages/login_page.dart';
import 'package:StockWatchListApp/pages/signup.dart';
import 'package:StockWatchListApp/pages/watch_list.dart';

import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'home_page.dart';

void main() async {
  //await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => WatchlistPage(),
        '/signUp': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
      },
    );
  }
}