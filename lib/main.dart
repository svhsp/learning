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
void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    title: "Hi",

    initialRoute: '/',
    routes: {
      // '/': (context) => CreateAccount(),
      '/': (context) => Login(),
      '/login': (context) => Login(),
      '/verify': (context) => Verification(),
      '/StockList': (context) => StockListPage(),

    },
  ));
}
