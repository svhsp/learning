import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  Future<void> _signUp() async {
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      FirebaseAuth.instance.currentUser?.sendEmailVerification();
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Verification email sent.'),
          );
        },
      );
      print(userCredential.user);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'An error occurred')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 45),

              Container(
                width: 400,
                height: 60,
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(hintText: 'Enter username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 5),

              Container(
                width: 400,
                height: 60,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Enter password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
              ),

              Container(
                width: 400,
                height: 60,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: 'Enter email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    } else if (!RegExp(r"^\S+@\S+\.\S+$").hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 20),

              Container(
                width: 250,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.deepPurpleAccent),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _signUp();
                    }
                  },
                  child: Text('Sign up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
