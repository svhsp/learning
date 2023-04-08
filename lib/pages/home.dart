// Packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'firebase_options.dart';

// Pages

import 'createacc.dart';
import 'login.dart';
import 'home.dart';

var profilePicture = "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/271deea8-e28c-41a3-aaf5-2913f5f48be6/de7834s-6515bd40-8b2c-4dc6-a843-5ac1a95a8b55.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzI3MWRlZWE4LWUyOGMtNDFhMy1hYWY1LTI5MTNmNWY0OGJlNlwvZGU3ODM0cy02NTE1YmQ0MC04YjJjLTRkYzYtYTg0My01YWMxYTk1YThiNTUuanBnIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.BopkDn1ptIwbmcKHdAOlYHyAOOACXW0Zfgbs0-6BY-E";

class Home extends StatelessWidget {
  Map data;

  Home(this.data);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(profilePicture),),
              SizedBox(height: 10),
              Text(data["username"], style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 20),
              Text(data["email"]),
              SizedBox(height: 30),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
              }, child: Text("Log out")),
              SizedBox(height: 20),
              Posts(data),
            ],
          ),
        ),
      ),
    );
  }
}

class Posts extends StatefulWidget {
  Map data;

  Posts(this.data);

  State<StatefulWidget> createState() => PostsState(data);
}

class PostsState extends State<Posts> {
  Map data;
  var posts;

  PostsState(this.data) {
    posts = data["posts"];
  }

  List<Widget> BuildList() {
    List<Widget> returnValue = <Widget>[];

    for (int i = 0; i < posts.length; i++) {
      returnValue.add(Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black26)],
        ),
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(profilePicture),),
                SizedBox(width: 15),
                Text(posts[i]["title"], style: TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            SizedBox(height: 15),
            Text(posts[i]["content"])
          ],
        ),
      ));
    }

    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          padding: const EdgeInsets.all(8),
          children: BuildList(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
        )
      ],
    );
  }
}