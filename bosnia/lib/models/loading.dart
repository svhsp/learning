import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading {
  Widget load = Center(
      child:Column(
          children:const [
            CircularProgressIndicator(),
            Text("LOADING")
          ],
      ),
  );
  Loading();
  factory Loading.fromJson(Map<String, dynamic> json) {
    return Loading();
  }
}