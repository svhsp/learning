import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';
import 'home_page.dart';

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