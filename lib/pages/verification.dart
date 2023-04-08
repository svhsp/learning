// Packages

import 'dart:async';
import 'package:learning/pages/createacc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/pages/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class CreateAccount extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => CreateAccountState();
// }

var profilePicture = "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/271deea8-e28c-41a3-aaf5-2913f5f48be6/de7834s-6515bd40-8b2c-4dc6-a843-5ac1a95a8b55.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzI3MWRlZWE4LWUyOGMtNDFhMy1hYWY1LTI5MTNmNWY0OGJlNlwvZGU3ODM0cy02NTE1YmQ0MC04YjJjLTRkYzYtYTg0My01YWMxYTk1YThiNTUuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.BopkDn1ptIwbmcKHdAOlYHyAOOACXW0Zfgbs0-6BY-E";

class Verification extends StatefulWidget {

  State<StatefulWidget> createState() {
    return VerificationState();
  }
}

class VerificationState extends State<Verification> {
  bool isEmailVerified = false;
  Timer? timer;

  Future<bool?> verified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email successfully verified")));

      timer?.cancel();
    }
  }

  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String getEmail() {
    String? email = FirebaseAuth.instance.currentUser!.email;

    if (email == null) {
      return "Error";
    }

    return email;
  }

  void initState() {
    super.initState();

    // FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => verified());
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Verify"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: isEmailVerified ?
              [
                Icon(Icons.manage_accounts, size: 69, color: Colors.grey,),
                SizedBox(height: 10),
                Text(getEmail(), style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 20),
                Text("Email verified!"),
                SizedBox(height: 30),
                ElevatedButton(onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                }, child: Text("Log Out")),
              ]
              : [
                Text('Check your email\n\nWaiting for verification...\n\n'),
                CircularProgressIndicator(),
              ],
          ),
        ),
      ),
    );
  }
}