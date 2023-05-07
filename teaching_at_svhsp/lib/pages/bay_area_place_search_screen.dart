import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teaching_at_svhsp/pages/search_location_screen.dart';

class BayAreaPlaceSearchScreen extends StatefulWidget {
  static final String pageName = "/bay_area_place_search";
  const BayAreaPlaceSearchScreen({Key? key}) : super(key: key);

  @override
  State<BayAreaPlaceSearchScreen> createState() =>
      _BayAreaPlaceSearchScreenState();
}

class _BayAreaPlaceSearchScreenState extends State<BayAreaPlaceSearchScreen> {
  String selectedPlace = "";

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
              onPressed: () async {
                final result = await showSearch(
                    context: context,
                    delegate: SearchLocationScreen(
                      locations: bayAreaPlaces,
                    ));
                setState(() {
                  selectedPlace = result;
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.blue)),
            ),
          ),
          selectedPlace == ''
              ? Container()
              : Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 35.0, vertical: 15.0),
                  color: Colors.deepOrange,
                  child: Text(
                    selectedPlace,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Scrollbar(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      bayAreaPlaces.elementAt(index),
                      style: TextStyle(fontSize: 15),
                    ),
                  );
                },
                itemCount: bayAreaPlaces.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  final List<String> bayAreaPlaces = [
    "Almaden",
    "Los Gatos",
    "Sunnyvale",
    "Mountain View",
    "San Francisco",
    "Fremont",
    "San Jose",
    "Morgan Hill",
    "Campbell",
    "San Mateo",
    "Saratoga",
    "Cupertino",
    "Palo Alto",
    "Los Altos",
    "Redwood City",
    "San Carlos",
    "Foster City",
    "San Bruno",
    "Daly City",
    "Union City",
    "Hayward",
    "Oakland",
    "Pleasanton",
    "San Ramon",
  ];
}
