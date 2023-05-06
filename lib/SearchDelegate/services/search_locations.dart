import 'package:flutter/material.dart';

class SearchLocations extends SearchDelegate<String> {
  late final List<String> bayAreaPlaces;
  final List<String> suggestedPlaces;

  SearchLocations({required this.bayAreaPlaces, required this.suggestedPlaces});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
      onPressed:  () {
          close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> allLocations = bayAreaPlaces.where(
        (californiaPlace) => californiaPlace.toLowerCase().contains(query.toLowerCase())
    ).toList();
    return ListView.builder(
      itemCount: allLocations.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(allLocations[index]),
        onTap: () {
          query = allLocations[index];
          close(context, query);
        },
      ),
    );

  }


  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> locationSuggestions = suggestedPlaces.where(
            (californiaPlace) => californiaPlace.toLowerCase().contains(query.toLowerCase())
    ).toList();
    return ListView.builder(
      itemCount: locationSuggestions.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(locationSuggestions[index]),
        onTap: () {
          query = locationSuggestions[index];
          close(context, query);
        },
      ),
    );
  }
  
}