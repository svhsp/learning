import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/pages/loginScreen.dart';
import 'package:login/pages/profileScreen.dart';
import 'package:login/pages/registerScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

