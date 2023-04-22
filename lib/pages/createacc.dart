// Packages

import 'package:learning/pages/createacc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/pages/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:learning/pages/stock_list_page.dart';
import 'package:flutter/material.dart';
import 'package:learning/pages/verification.dart';
import 'package:learning/pages/stock_list_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learning/pages/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:learning/pages/createacc.dart';
import 'package:learning/pages/verification.dart';
import 'package:learning/pages/login.dart';

// Page

import 'verification.dart';
import 'login.dart';

// class CreateAccount extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => CreateAccountState();
// }

class CreateAccount extends StatelessWidget {
  static Future<User?> SignUp({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email,
          password: password);
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
      return userCredential.user;
    }
    on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password is too weak")));
      }
      else if (error.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Account already exists")));
      }
      else {
        print(error.toString());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unknown authentication error")));
      }
      return null;
    }
    catch (error) {
      print("balls");
      print(error.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unknown error")));
      return null;
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Create Account"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(45),
          child: CreateAccountForm(),
        ),
      ),
    );
  }
}

class CreateAccountForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateAccountFormState();
}

class CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  String? race;

  void dispose() {
    email.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add_alt_1, size: 69, color: Colors.grey,),
            SizedBox(height: 15),
            TextFormField(
              decoration: InputDecoration(hintText: "Email"),
              controller: email,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter something";
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(hintText: "Password"),
              controller: password,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter something";
                }
                return null;
              },
              obscureText: true,
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await CreateAccount.SignUp(email: email.text, password: password.text, context: context);
                if (FirebaseAuth.instance.currentUser != null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Verification()));
                }
              }
            }, child: Text("Create Account")),
            SizedBox(height: 10),
            TextButton(onPressed: () {
              // Navigator.of(context).pushNamed('/login');
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            }, child: Text("Already have an account?"))
          ],
        )
    );
  }
}