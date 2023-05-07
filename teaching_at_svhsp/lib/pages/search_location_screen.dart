import 'dart:math';

import 'package:flutter/material.dart';

class SearchLocationScreen extends SearchDelegate {
  final List<String> locations;
  SearchLocationScreen({required this.locations});

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
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> searchResult = locations
        .where((bayAreaPlace) =>
            bayAreaPlace.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResult.elementAt(index)),
          onTap: () {
            query = searchResult.elementAt(index);
            close(context, query);
          },
        );
      },
      itemCount: searchResult.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> searchResultTemp = locations
        .where((bayAreaPlace) =>
            bayAreaPlace.toLowerCase().contains(query.toLowerCase()))
        .toList();
    final List<String> searchResult =
        searchResultTemp.sublist(0, min(3, searchResultTemp.length));
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResult.elementAt(index)),
          onTap: () {
            query = searchResult.elementAt(index);
            close(context, query);
          },
        );
      },
      itemCount: searchResult.length,
    );
  }
}
