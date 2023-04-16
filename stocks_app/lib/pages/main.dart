import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Widgets/EmailVerificationScreen.dart';
import '../Resources/firebase_options.dart';
import '../Resources/firebase_constants.dart';
import 'emailandpassword sign in.dart';
import 'stockpage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.collection("Sarajevo69420").add({
  //   "name": "Jackson",
  //   "favorites": {
  //     "food": "Electricity",
  //     "color": "Magenta",
  //     "subject": "Math",
  //     "activities": {
  //       "sports" : "cricket",
  //       "country" : "bosnia",
  //     },
  //   },
  //   "age": 69420
  // });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Creator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/': (context) => const MyHomePage(title: "Sign Up"),
        '/login': (context) => const loginPage(title: "Login"),
        '/homePage': (context) => const StocksPage(title: "Stock"),
      },
    );
  }
}




