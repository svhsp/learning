import 'package:flutter/material.dart';
import 'package:login/pages/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
String enteredPassword = '';
String enteredUsername = '';
String correctEmail = '';
String email = '';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  static Future<User?> logIn(
      {required String userEmail,
        required String password,
        required BuildContext context}) async {
    try {
      print("email " + userEmail + "password " + password);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: userEmail, password: password);

      if (userCredential.user?.emailVerified == true) {
        await Navigator.of(context).pushNamedAndRemoveUntil('/ticker', (route) => false, arguments: data(userEmail, password));
      } else {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Text('cannot log in bozo u havent verified.'),
          );
        });
      }

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('wrong password bozo')));
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('invalid email get better')));
      } else if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('this user is not found try again :D')));
      } else if (e.code == 'user-disabled') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('this email has been disables, try again :D')));
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.deepPurpleAccent,
      ),

      body: Form(
        key: _formKey,
        child: Center(child: Column(
          children: [
            SizedBox(width: 10, height: 45),
            Container(
              width: 400,
              height: 60,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(hintText: 'Enter your email'),
                onSaved: (String? value) {
                  setState(() {
                    email = value!;
                  });},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email.';
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
                controller: controller2,
                obscureText: true,
                decoration: InputDecoration(hintText: 'Enter your password'),
                onSaved: (String? value) {
                  setState(() {
                    enteredPassword = value!;
                  });},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password.';
                  }
                  return null;
                },
              ),
            ),

            SizedBox(width: 10, height: 15),

            Container(
              width: 100,
              height: 40,
              child: ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.deepPurpleAccent),onPressed: () async {
                await logIn(userEmail: controller.text.toString(), password: controller2.text.toString(), context: context);
              }, child: Text('Login', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
            ),

            SizedBox(width: 10, height: 10),

            Container(
              width: 250,
              margin: EdgeInsets.only(left: 60),
              height: 40,
              child: Row(children: [
                Text('No account?', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16, color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    await Navigator.pushNamed(context, '/register');
                  },
                  child: const Text('Register Here'),
                ),
              ],),
            ),

          ],
        ),),
      ),
    );
  }
}