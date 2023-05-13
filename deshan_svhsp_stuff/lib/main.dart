import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/pages/loginScreen.dart';
import 'package:login/pages/profileScreen.dart';
import 'package:login/pages/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/queryPage.dart';
import 'package:login/services/fetchServices.dart';import 'models/result.dart';
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
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // List<String> test = List.empty(growable: true);
  // test.add('https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=GOOG&apikey=G4UJ9ECYT8N1K1O6');

  // FetchServices.getStockData(test);
  List<SearchResult> test = await FetchServices.getStockTickers('A');
  print("TEST: " + test.toString());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/profile': (context) => ProfileScreen(),
        '/ticker': (context) => TickerScreen(),
        '/query': (context) => QueryScreen(),
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       initialRoute: '/ticker',
//       routes: {
//         '/ticker': (context) =>
//             Scaffold(
//               appBar: AppBar(
//                 backgroundColor: Colors.white70,
//                 title: Row(
//                   children: [
//                     IconButton(onPressed: () {
//
//                     }, icon: Icon(Icons.search, color: Colors.black)),
//                     const Text('                                                                      Login', style: TextStyle(fontSize: 26, color: Colors.black),),
//                   ],
//                 ),
//               ),
//               body: TickerScreen(),
//             ),
//       },
//     );
//   }
// }
