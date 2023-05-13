import 'package:flutter/material.dart';

class SearchBayAreaPlacePage extends SearchDelegate<String> {
  final List<String> places;

  SearchBayAreaPlacePage({required this.places});

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
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = places.where((place) => place.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final place = results[index];
        return ListTile(
          title: Text(place),
          onTap: () {
            close(context, place);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = places.where((place) => place.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        final place = results[index];
        return ListTile(
          title: Text(place),
          onTap: () {
            close(context, place);
          },
        );
      },
    );
  }
}