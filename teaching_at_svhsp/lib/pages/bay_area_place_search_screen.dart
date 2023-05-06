import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BayAreaPlaceSearchScreen extends StatefulWidget {
  static final String pageName = "/bay_area_place_search";
  const BayAreaPlaceSearchScreen({Key? key}) : super(key: key);

  @override
  State<BayAreaPlaceSearchScreen> createState() =>
      _BayAreaPlaceSearchScreenState();
}

class _BayAreaPlaceSearchScreenState extends State<BayAreaPlaceSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bay Area Place Search',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
