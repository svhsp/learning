import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profile/search_locations.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedPlace = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Delegate',
          style: TextStyle(color: Colors.white, fontSize: 18.0),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          OutlinedButton.icon(
            label: Text('Search'),
            icon: Icon(Icons.search),
            style: OutlinedButton.styleFrom(
              primary: Colors.deepOrange,
              side: BorderSide(color: Colors.blue),
            ),
            onPressed: () async {
              final finalResult = await showSearch(
                  context: context,
                  delegate: SearchLocations(
                      bayAreaPlaces: bayAreaPlaces,
                      mainBayAreaPlaces: mainBayAreaPlaces));
              setState(() {
                selectedPlace = finalResult!;
              });

            },
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
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
          Expanded(
            child: ListView.builder(
              itemCount: bayAreaPlaces.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bayAreaPlaces[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final List<String> bayAreaPlaces = [
  'A1',
  'A2',
  'A3',
  'B1',
  'B2',
  'B3',
  'C1',
  'C2',
  'C3',
  'D1',
  'D2',
  'D3',
  'E1',
  'E2',
  'E3',
  'F1',
  'F2',
  'F3',
  'G1',
  'G2',
  'G3',
  'H1',
  'H2',
  'H3',
  'I1',
  'I2',
  'I3',
  'J1',
  'J2',
  'J3',
  'K1',
  'K2',
  'K3',
  'L1',
  'L2',
  'L3',
  'M1',
  'M2',
  'M3',
  'N1',
  'N2',
  'N3',
  'O1',
  'O2',
  'O3',
  'P1',
  'P2',
  'P3',
  'Q1',
  'Q2',
  'Q3',
  'R1',
  'R2',
  'R3',
  'S1',
  'S2',
  'S3',
  'T1',
  'T2',
  'T3',
  'U1',
  'U2',
  'U3',
  'V1',
  'V2',
  'V3',
  'W1',
  'W2',
  'W3',
  'X1',
  'X2',
  'X3',
  'Y1',
  'Y2',
  'Y3',
  'Z1',
  'Z2',
  'Z3',
];

final List<String> mainBayAreaPlaces = [
  'A1',
  'B1',
  'C1',
  'D1',
  'E1',
  'F1',
  'G1',
  'H1',
  'I1',
  'J1',
  'K1',
  'L1',
  'M1',
  'N1',
  'O1',
  'P1',
  'Q1',
  'R1',
  'S1',
  'T1',
  'U1',
  'V1',
  'W1',
  'X1',
  'Y1',
  'Z1',
];
