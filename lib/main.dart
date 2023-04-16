import 'package:flutter/material.dart';
import 'models/signup.dart';
import 'models/login.dart';
import 'pages/home_page.dart';

void main() {
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