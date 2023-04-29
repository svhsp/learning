import 'package:flutter/material.dart';
import 'pages/loginScreen.dart';
import 'pages/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/Services.dart';
import 'models/stock.dart';
import 'pages/TickerScreen.dart';
import 'firebase_options.dart';

String username = '';
String password = '';
String enteredPassword = '';
String enteredUsername = '';
String email = '';
String age = '';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  List<String> test = List.empty(growable: true);
  test.add('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=GOOG&apikey=G4UJ9ECYT8N1K1O6');

  FetchServices.getStockData(test);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/ticker': (context) => const TickerScreen(),
      },
    );
  }
}

