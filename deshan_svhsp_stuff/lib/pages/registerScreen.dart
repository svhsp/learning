import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/pages/loginScreen.dart';
String username = '';
String password = '';
String enteredPassword = '';
String enteredUsername = '';
String email = '';
String age = '';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => new RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  static Future<User?> signUp(
      {required String userEmail,
        required String password,
        required BuildContext context}) async {
    try {
      print("email " + userEmail + "password " + password);
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: userEmail, password: password);
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
      print("email sent");
      showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text('verification email sent.'),
        );
      });
      print(userCredential.user);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('The account already exists for that email.')));
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      print(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Profile'), backgroundColor: Colors.deepPurpleAccent,), body:Form(
      key: _formKey,
      child: Center(
        child:  Column(
        children: <Widget>[
          SizedBox(width: 10, height: 45),

          Container(
            width: 400,
            height: 60,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Enter username'),
              onSaved: (String? value) {
                setState(() {
                  username = value!;
                });},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter username.';
                }
                return null;
              },
            ),
          ),

          SizedBox(width: 10, height: 5),

          Container(
            width: 400,
            height: 60,
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(hintText: 'Enter password'),
              onSaved: (String? value) {
                setState(() {
                  password = value!;
                });},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter password.';
                } else if (value.length < 8) {
                  return 'Password must be more 8 or more characters.';
                }
                return null;
              },
            ),
          ),

          Container(
            width: 400,
            height: 60,
            child: TextFormField(
                decoration: InputDecoration(hintText: 'Enter email'),
                onSaved: (String? value) {
                  setState(() {
                    email = value!;
                  });},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter an email';
                  } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Enter a valid email';
                  } else {
                    return null;
                  }
                }
            ),
          ),

          SizedBox(width: 10, height: 20),
          Container(
            width: 250,
            height: 40,
            child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.deepPurpleAccent), onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
              }
              await signUp(userEmail: email, password: passwordController.text.toString(), context: context);
              await Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            }, child: Text('Create account and verify', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),)),
          ),
        ],
      ),),
    ),);
  }
}