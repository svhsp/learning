import 'package:bosnia/pages/messaging_reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:bosnia/reusable_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

String email = "";

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: hexStringColor("A89B9D"),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Sign In",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: hexStringColor("CFCFEA"),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            reusableTextField(
                'Enter Email', Icons.email, false, _emailTextController),

            const SizedBox(height: 20,),

            reusableTextField('Enter Password', Icons.lock_outline, true,
                _passwordTextController),

            const SizedBox(height: 20,),

            signInSignUpButton(context, true, () {
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                  email: _emailTextController.text,
                  password: _passwordTextController.text)
                  .then((value) {
                    email = _emailTextController.text;
                Navigator.pushReplacementNamed(context, '/groups');
              }).onError((error, stackTrace) {
                print("Error ${error.toString()}");
              });
            }),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Forgot Password?",
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(
                  width: 2,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ResetPasswordScreen()));
                  },
                  child: const Text(
                    "Reset Password",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have account?",
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(
                  width: 2,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signUp');
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),);
  }
}