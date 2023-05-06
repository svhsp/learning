import 'package:flutter/material.dart';
import 'package:login/pages/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/query.dart';
import 'package:login/services/DatabaseServices.dart';

import '../models/stock.dart';
import '../services/fetchServices.dart';

class QueryScreen extends StatefulWidget {
  const QueryScreen({super.key});

  @override
  QueryScreenState createState() => new QueryScreenState();
}

class QueryScreenState extends State<QueryScreen> {
  // List<String> searchResults = [
  //   "AMD",
  //   "APPL",
  //   "MSFT",
  //   "M",
  //   "GOOG",
  // ];
  //
  // List<String> searchSuggestions = [
  //   "AMD",
  //   "APPL",
  //   "MSFT",
  //   "M",
  //   "GOOG",
  // ];

  List<String> searchResults = [
    "San Francisco",
    "Palo Alto",
    "San Jose",
    "Campbell",
    "Los Altos",
    "Daly City",
    "Milpitas",
    "Fremont",
    "Union City",
    "Oakland",
    "South San Francisco",
    "Half Moon Bay",
    "Cupertino",
    "Alum Rock",
    "Mountain View",
    "Los Gatos",
    "Saratoga",
    "Morgan Hill",
    "Gilroy",
    "Santa Cruz",
    "Pasadena",
    "San Mateo",
    "Foster City",
    "Millbrae",
    "Burlingame",
    "Livermore",
    "Pleasanton",
    "San Ramon",
    "Dublin",
    "Redwood City",
    "Santa Clara",
    "Hayward",
    "San Bruno",
    "Almaden",
    "Lick",
    "Sunol",
    "Richmond",
    "San Rafael",
  ];
  List<String> searchSuggestions = [
    "San Francisco",
    "Palo Alto",
    "San Jose",
    "Campbell",
    "Los Altos",
    "Daly City",
    "Milpitas",
    "Fremont",
    "Union City",
    "Oakland",
    "South San Francisco",
    "Half Moon Bay",
    "Cupertino",
    "Alum Rock",
    "Mountain View",
    "Los Gatos",
    "Saratoga",
    "Morgan Hill",
    "Gilroy",
    "Santa Cruz",
    "Pasadena",
    "San Mateo",
    "Foster City",
    "Millbrae",
    "Burlingame",
    "Livermore",
    "Pleasanton",
    "San Ramon",
    "Dublin",
    "Redwood City",
    "Santa Clara",
    "Hayward",
    "San Bruno",
    "Almaden",
    "Lick",
    "Sunol",
    "Richmond",
    "San Rafael",
  ];
  String selectedPlace = '';
  String query = '';
  @override
  Widget build (BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.deepPurpleAccent, title: Text("Bay Area Search City App"),),
        body: Column(
          children: [
            SizedBox(height: 20,),
            Center(
              child: Container(
                width: 130,
                height: 45,
                child: OutlinedButton(
                  onPressed: () async {
                    final finalResult = await showSearch(context: context, delegate: SearchLocations(allCaliforniaPlaces: searchResults, allCaliforniaSuggestions: searchSuggestions));
                    print('FINAL RESULT: ' + finalResult.toString());
                    setState(() {
                      selectedPlace = finalResult!;
                    });
                  },
                  child: Row(
                    children: [
                      Text("Search", style: TextStyle(fontSize: 20, color: Colors.black),),
                      SizedBox(width: 8,),
                      Icon(Icons.search),
                    ],
                  ),
                ),
              ),
            ),

            selectedPlace == '' ? Container() : Container(child: Text(selectedPlace),),

            Expanded(child:
              ListView.builder(
              itemCount: searchSuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(searchSuggestions[index]),
                  );
                },
               ),
    ),
          ],
        ),
      ),
    );
  }
}