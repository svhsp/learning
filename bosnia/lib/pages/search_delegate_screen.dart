import 'package:bosnia/models/loading.dart';
import 'package:bosnia/pages/stock_list_screen.dart';
import 'package:flutter/material.dart';

import '../models/stock.dart';

class SearchLocations extends SearchDelegate {

  final List<String> locations;
  final List<String> suggestedLocations;

  SearchLocations({required this.locations, required this.suggestedLocations});

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
    final List<String> searchedLocations = locations.where(
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
    final List<String> searchedSuggestedLocations = suggestedLocations.where(
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

class SearchStocks extends SearchDelegate {

  SearchStocks();

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
    return FutureBuilder<List<String>>(
        future: stockFetcher.searchStock(query),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.done ?
          ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, idx) {
              return ListTile(
                title: Text(snapshot.data![idx]),
                onTap: () {
                  query = snapshot.data![idx];
                  close(context, query);
                  print(query);
                },
              );
            },
          )
              : Loading().load;
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query == '') {
      return Container();
    }
    return FutureBuilder<List<String>>(
      future: stockFetcher.searchStock(query),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.done ?
            ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, idx) {
              return ListTile(
                title: Text(snapshot.data![idx]),
                onTap: () {
                  query = snapshot.data![idx];
                  close(context, query);
                  print(query);
                },
              );
            },
          )
        : Loading().load;
      }
    );
  }
}