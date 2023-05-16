import 'package:bosnia/pages/stock_verify_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bosnia/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isEmailVerified = false;
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: hexStringColor("A89B9D"),
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: hexStringColor("CFCFEA"),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            reusableTextField('Enter Username', Icons.person_outline, false,
                _userNameTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField('Enter Email', Icons.person_outline, false,
                _emailTextController),
            const SizedBox(
              height: 20,
            ),
            reusableTextField('Enter Password', Icons.lock_outline, true,
                _passwordTextController),
            const SizedBox(
              height: 20,
            ),
            signInSignUpButton(context, false, () {
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                  email: _emailTextController.text,
                  password: _passwordTextController.text)
                  .then((value) {
                    FirebaseFirestore.instance.collection("messaging-usernames").doc(_emailTextController.text).set({
                      "username" : _userNameTextController
                    });
                    Navigator.pushNamed(context, '/groups');
              }).onError((error, stackTrace) {
                print("Error ${error.toString()}");
              });
            }),
          ],
        ),
      ),
    );
  }
}