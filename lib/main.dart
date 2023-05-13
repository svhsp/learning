
import 'package:flutter/material.dart';
import 'package:untitled/pages/signup.dart';
import 'package:untitled/pages/watch_list.dart';
//import 'package:firebase_core/firebase_core.dart';
import '../models/stock_info.dart';
import 'pages/PopularPlacesInCali.dart';
import 'pages/datatable_test.dart';
import 'pages/home_page.dart';

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
