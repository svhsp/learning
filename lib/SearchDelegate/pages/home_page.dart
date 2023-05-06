import 'package:flutter/material.dart';
import 'package:stonks/SearchDelegate/services/search_locations.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {
  String selectedPlace = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Delegate Class',
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
             final finalResult = await showSearch(context: context, delegate: SearchLocations(bayAreaPlaces: bayAreaPlaces, suggestedPlaces: suggestedPlaces));
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
                fontWeight: FontWeight.bold, color: Colors.white),
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
          )
          ),
        ],
      ),
    );
  }
}

final List <String> bayAreaPlaces = ['Palo Alto', 'San Jose', 'Santa Clara',
  'Los Altos', 'Los Gatos', 'Mountain View', 'Redwood City', 'Sacramento', 'San Francisco'];

final List <String> suggestedPlaces = ['San Jose', 'Santa Clara',
  'Los Altos', 'Los Gatos'];