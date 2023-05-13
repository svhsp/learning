import 'package:flutter/material.dart';

class SearchLocations extends SearchDelegate {

  final List<String> searchElements;
  final List<String> suggestedSearchElements;

  SearchLocations({required this.searchElements, required this.suggestedSearchElements});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          }
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, query);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<String> searchedLocations = searchElements.where(
      (location) => location.toLowerCase().contains(
        query.toLowerCase(),
      ),
    ).toList();
    return ListView.builder(
      itemCount: searchedLocations.length,
      itemBuilder: (context, idx) => ListTile(
        title: Text(searchedLocations[idx]),
        onTap: () {
          query = searchedLocations[idx];
          close(context, query);
          print(query);
        },
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> searchedSuggestedLocations = suggestedSearchElements.where(
          (suggestedLocation) => suggestedLocation.toLowerCase().contains(
        query.toLowerCase(),
      ),
    ).toList();
    return ListView.builder(
        itemCount: searchedSuggestedLocations.length,
        itemBuilder: (context, idx) => ListTile(
          title: Text(searchedSuggestedLocations[idx]),
          onTap: () {
            query = searchedSuggestedLocations[idx];
            close(context, query);
            print(query);
          },
        )
    );
  }
  
}