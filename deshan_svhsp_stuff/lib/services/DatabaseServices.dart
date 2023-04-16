import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../models/stock.dart';

class DatabaseServices {
  Future<List<String>?> getUserPreferences (String userId) async {
    final docRef = FirebaseFirestore.instance.collection("preferences").doc(userId);
    List<String> result = List.empty(growable: true);

    DocumentSnapshot documentSnapshot = await docRef.get();
    if (documentSnapshot.exists) {
      final data = documentSnapshot.data() as Map<String, dynamic>;

      for (dynamic stock in data["stocks"]) {
        result.add(stock.toString());
      }
    }

    return result;
  }

  Future<String> getUrl () async {
    final docRef = FirebaseFirestore.instance.collection("apikeys").doc("appConfig");
    String result = "";

    DocumentSnapshot documentSnapshot = await docRef.get();
    if (documentSnapshot.exists) {
      final data = documentSnapshot.data() as Map<String, dynamic>;
      result = data['url'];
    }

    return result;
  }
}