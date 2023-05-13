

import 'package:flutter/material.dart';

class SearchLocations extends SearchDelegate<String> {
  final List<String> bayAreaPlaces;
  final List<String> mainBayAreaPlaces;

  SearchLocations({required this.bayAreaPlaces, required this.mainBayAreaPlaces});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query = '';
      }),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
      close(context, query);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> allLocations = bayAreaPlaces.where((bayAreaPlace) => bayAreaPlace.toLowerCase().contains(query.toLowerCase(),),).toList();

    return ListView.builder(
      itemCount: allLocations.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allLocations[index]),
        onTap: () {
          query = allLocations[index];
          close(context, query);
          print(query);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> bayAreaSuggested = mainBayAreaPlaces.where((mainBayArea) => mainBayArea.toLowerCase().contains(query.toLowerCase(),),).toList();

    return ListView.builder(
      itemCount: bayAreaSuggested.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(bayAreaSuggested[index]),
        onTap: () {
          query = bayAreaSuggested[index];
          close(context, query);
          print(query);
        },
      ),
    );
  }
  
}