import 'package:flutter/material.dart';
import 'SearchBayAreaPlacePage.dart';

class BayAreaPlaces extends StatefulWidget {
  @override
  _BayAreaPlacesState createState() => _BayAreaPlacesState();
}

class _BayAreaPlacesState extends State<BayAreaPlaces> {
  List<String> _places = [    'Golden Gate Bridge',    'Alcatraz Island',    'Fishermans Wharf',    'Chinatown',    'San Francisco Cable Cars',    'Muir Woods National Monument',    'Sausalito',    'Twin Peaks',    'Palace of Fine Arts Theatre',    'Lombard Street',    'McDonalds',    'In and Out',    'Wendys',    'Valley Fair',    'Burger King',    'Jack in the Box'  ];

  String _searchResult = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search Places'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final result = await showSearch(
                  context: context,
                  delegate: SearchBayAreaPlacePage(places: _places),
                );
                setState(() {
                  _searchResult = result!;
                });
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Result: $_searchResult'),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _places.length,
                itemBuilder: (context, index) {
                  final place = _places[index];
                  return ListTile(
                    title: Text(place),
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