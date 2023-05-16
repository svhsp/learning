import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/group.dart';
import '../models/message.dart';
import '../pages/messaging_groups_screen.dart';
import '../pages/messaging_login_screen.dart';

class GroupFetcher {
  static Future<List<Group>> getGroups() async {
    List<Group> Groups = [];
    var querySnapshot = await db.collection("messaging-app").get();
    for (var docSnapshot in querySnapshot.docs) {
      bool PartOfGroup = false;
      for(var key in docSnapshot.data().keys) {
        if (docSnapshot.data()[key].toString().toLowerCase() == email.toLowerCase()) {
          PartOfGroup = true;
          break;
        }
      }
      if (!PartOfGroup) {
        break;
      }
      var querySnapshot2 = await db.collection(docSnapshot.id).get();
      List<Message> messageList = [];
      for (var docSnapshot2 in querySnapshot2.docs) {
        DateTime time =  DateTime.parse(docSnapshot2.data()["datetime"].toDate().toString());
        String email = docSnapshot2.data()["email"];
        String message = docSnapshot2.data()["value"];
        messageList.insert(0, Message(messageEmail: email, messageDateTime: time, messageValue: message));
      }
      Groups.add(Group(id: docSnapshot.id, name: docSnapshot.data()["name"], messages: messageList));
    }
    print("Got Groups");
    print(Groups);
    return Groups;
  }
  static Future<Map<String, String>> getUsers(Map<String, String> map) async {
    map.clear();
    var querySnapshot = await db.collection("messaging-usernames").get();
    for(var docSnapshot in querySnapshot.docs) {
      map[docSnapshot.id] = docSnapshot.data()["username"];
    }
    print("Got Usernames");
    print(map);
    return map;
  }
}