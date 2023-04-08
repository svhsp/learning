import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class data {
  String email;
  String password;

  data(this.email, this.password);
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => new ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build (BuildContext context) {

    final args = ModalRoute.of(context)!.settings.arguments as data;

    return Scaffold(appBar: AppBar(title: Text('Profile'), backgroundColor: Colors.deepPurpleAccent,), body: Center(
      child: Column(
        children: [
          SizedBox(
            width: 100,
            height: 100,
          ),

          Container(
            width: 100,
            height: 100,
            child: CircleAvatar(backgroundImage: AssetImage('hutao.png'),
            ),
          ),

          SizedBox(
            width: 20,
            height: 20,
          ),

          Text(args.email, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
          Text('Password: ' + args.password, style: TextStyle(fontSize: 24),),
          Text('You are logged in and is currently viewing your profile. ', style: TextStyle(fontSize: 20),),

          ElevatedButton(onPressed: () async {
            try {
              FirebaseAuth.instance.signOut();
              await Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            } catch (e) {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  content: Text('Could not log out. Error ' + e.toString()),
                );
              });
            }

          }, child: Text('Log Out')),
        ],
      ),
    ),
    );
  }
}