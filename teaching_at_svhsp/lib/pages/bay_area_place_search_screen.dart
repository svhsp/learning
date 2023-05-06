import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BayAreaPlaceSearchScreen extends StatefulWidget {
  static final String pageName = "/bay_area_place_search";
  static final List<String> bayAreaPlaces = [
    "Almaden",
    "Los Gatos",
    "Sunnyvale",
    "Mountain View",
    "San Francisco",
    "Fremont",
    "San Jose",
    "Morgan Hill"
  ];

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
        children: [
          Center(
            child: ElevatedButton.icon(
              icon: Icon(Icons.search, color: Colors.red),
              label: Text("Search", style: TextStyle(color: Colors.red)),
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.blue)),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  BayAreaPlaceSearchScreen.bayAreaPlaces.elementAt(index),
                  style: TextStyle(fontSize: 15),
                ),
              );
            },
            itemCount: BayAreaPlaceSearchScreen.bayAreaPlaces.length,
          )
        ],
      ),
    );
  }
}
