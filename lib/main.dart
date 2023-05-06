import 'package:flutter/material.dart';
import 'package:learning/pages/PopularPlacesInCali.dart';
import 'package:learning/pages/stock_list_page.dart';
import 'package:learning/pages/verification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learning/pages/firebase_options.dart';
import 'package:learning/pages/login.dart';
import 'package:learning/services/stock_fetch.dart';
void main() async {
  StockFetch;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: "Hi",

    initialRoute: '/',

    routes: {
      // '/': (context) => CreateAccount(),
      '/': (context) => BayAreaPlaces(),
      '/login': (context) => Login(),
      '/verify': (context) => Verification(),
      '/StockList': (context) => StockListPage(),

      },
    ));
  }
