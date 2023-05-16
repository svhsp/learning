import 'dart:math';

import 'package:bosnia/pages/messaging_groups_screen.dart';
import 'package:flutter/material.dart';
import '../reusable_widgets.dart';
import 'messaging_login_screen.dart';
import 'package:bosnia/models/group.dart';
import 'package:bosnia/models/loading.dart';
import 'package:bosnia/models/message.dart';
import 'package:bosnia/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:bosnia/firebase_constants.dart';
import 'package:bosnia/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/group_fetcher.dart';
import 'messaging_login_screen.dart';

const allChars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
bool joiningGroup = false;
String newGroup = "";

class AddGroupPage extends StatefulWidget {
  const AddGroupPage({Key? key}) : super(key: key);

  @override
  State<AddGroupPage> createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  final TextEditingController _groupNameTextController = TextEditingController();
  final TextEditingController _joinCodeTextController = TextEditingController();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => allChars.codeUnitAt(Random().nextInt(allChars.length))));

  Future<void> createGroup() async {
    newGroup = getRandomString(6);
    var snap = await db.collection("group-$newGroup").get();
    while(snap.size != 0) {
      newGroup = getRandomString(6);
      snap = await db.collection("group-$newGroup").get();
    }
    db.collection("messaging-app").doc("group-$newGroup").set({
      "member-1" : email,
      "members" : 1,
      "name" : _groupNameTextController.text,
    });
    db.collection("group-$newGroup").doc("Temporary Start Message").set({
      "datetime" : Timestamp.now(),
      "email" : "temporary",
      "value" : "Welcome to your new group, \"${_groupNameTextController.text}\", \"${usernames[email]}\", the join code for the group is \"$newGroup\""
    });
    Navigator.pop((context));
  }

  Future<void> joinGroup() async {
    var snap = await db.collection("group-${_joinCodeTextController.text}").get();
    if (snap.size == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Not a proper join code")));
      return;
    }
    var snap2 = await db.collection("messaging-app").doc("group-${_joinCodeTextController.text}").get();
    int members = snap2["members"] + 1;
    db.collection("messaging-app").doc("group-${_joinCodeTextController.text}").update({
      "members": members,
    });
    db.collection("messaging-app").doc("group-${_joinCodeTextController.text}").update({
      "member-$members": email,
    });
    Navigator.pop((context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: hexStringColor("A89B9D"),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Add a Group",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: hexStringColor("CFCFEA"),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Create A Group", style: TextStyle(fontSize: 25),),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 50),
                  child: TextField(
                    controller: _groupNameTextController,
                    enableSuggestions: true,
                    autocorrect: true,
                    cursorColor: Colors.grey,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "New Group Name",
                      labelStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          createGroup();
                        },
                      ),
                    ),
                  ),
                ),
                const Text("Join A Group", style: TextStyle(fontSize: 25),),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 50),
                  child: TextField(
                    controller: _joinCodeTextController,
                    enableSuggestions: true,
                    autocorrect: true,
                    cursorColor: Colors.grey,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelText: "Join Code",
                      labelStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.white.withOpacity(0.4),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          joinGroup();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}