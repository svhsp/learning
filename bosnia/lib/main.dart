import 'package:bosnia/pages/stock_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bosnia/pages/stock_login_screen.dart';
import '/pages/stock_list_screen.dart';
import 'package:bosnia/pages/serach_bay_area_screen.dart';

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
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        /* STOCK APP ROUTES
        '/': (context) => const SignIn(),
        '/signUp': (context) => const SignUpScreen(),
        '/home': (context) => const HomePage(),
        */
        '/': (context) => const BayAreaSearch(),
      },
    );
  }
}