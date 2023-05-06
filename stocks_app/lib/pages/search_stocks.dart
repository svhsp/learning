import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Widgets/EmailVerificationScreen.dart';
import '../Resources/firebase_options.dart';
import '../Resources/firebase_constants.dart';
import 'emailandpassword sign in.dart';
import 'stockpage.dart';
import 'demo_future_builder.dart';
import 'search_stocks.dart';

class search extends StatefulWidget {
  const search({super.key, required this.title});
  final String title;
  @override
  State<search> createState() => _search();
}

class _search extends State<homepage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('logout'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrangeAccent[800],
                    onPrimary: Colors.white,
                    textStyle: TextStyle(fontSize:20),
                  )
              ),
            ]),
      ),
    );
  }
}