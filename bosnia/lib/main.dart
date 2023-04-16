import 'package:bosnia/Stock Fetcher Project/pages/up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bosnia/Stock Fetcher Project/pages/in.dart';
import '/Stock Fetcher Project/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const SignIn(),
        '/signUp': (context) => const SignUpScreen(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}