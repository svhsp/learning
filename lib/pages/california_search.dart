import 'package:flutter/material.dart';

class CaliforniaSearch extends SearchDelegate<String> {
  final List<String> californiaCities;
  final List<String> suggestedCaliforniaCities;

  CaliforniaSearch(
      {required this.californiaCities, required this.suggestedCaliforniaCities});

  @override
  String get searchFieldLabel => 'Search for a city';

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];

  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> allLocations = californiaCities
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: allLocations.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(allLocations[index]),
          onTap: () {
            query = allLocations[index];
            close(context, query);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> locationSuggestions = suggestedCaliforniaCities
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();


    return ListView.builder(
      itemCount: locationSuggestions.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(locationSuggestions[index]),
          onTap: () {
            query = locationSuggestions[index];
            close(context, query);
          },
        );
      },
    );
  }
}
