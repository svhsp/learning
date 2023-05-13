import 'package:flutter/material.dart';
import 'home.dart';
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

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      home: Home(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/ticker': (context) => const TickerScreen(),
      },
    );
  }
}

