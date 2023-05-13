import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:learning/pages/sign_in.dart';
import 'package:learning/pages/sign_up.dart';
import 'package:learning/pages/stock_list.dart';
import 'package:learning/pages/world_time_choose_location.dart';
import 'package:learning/pages/world_time_home.dart';
import 'pages/loading.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        //Default Page
        '/': (context) => const SignInScreen(),

        //Stock App Routes
        '/loading': (context) => Loading(app: 'world_time'),
        '/stock_signUp': (context) => const SignUpScreen(),
        '/stock_home': (context) => StockListPage(listStockInfo: const [],),

        //World Time App Routes
        '/world_time_location': (context) => ChooseLocation(),
        '/world_time_home': (context) => Home(),
      },
    );
  }
}










