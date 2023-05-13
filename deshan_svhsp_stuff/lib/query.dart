import 'package:flutter/material.dart';
import 'package:login/pages/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login/services/DatabaseServices.dart';

import '../models/stock.dart';
import '../services/fetchServices.dart';
import 'models/result.dart';

class SearchLocations extends SearchDelegate<String> {
  final List<String> allCaliforniaPlaces;
  final List<String> allCaliforniaSuggestions;

  SearchLocations({required this.allCaliforniaPlaces, required this.allCaliforniaSuggestions});

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: () {
        query = '';
      }, icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: () {close(context, query);},);
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // final List<String> allLocations = allCaliforniaPlaces.where(
    //     (place) => place.toLowerCase().contains(query.toLowerCase()),
    // ).toList();
    List<String> allLocations = List.empty(growable: true);

    if (query != '') {
      return FutureBuilder(future: FetchServices.getStockTickers(query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              for (SearchResult result in snapshot.data!) {
                if (allLocations.contains(result.tickerName!) == false) {
                  allLocations.add(result.tickerName!);
                }
              }

              print("SUGGESTIONS: " + allLocations.toString());

              return ListView.builder(itemCount: allLocations.length, itemBuilder: (context, index) {
                return ListTile(title: Text(allLocations[index]), onTap: () {
                  query = allLocations[index];
                  close(context, query);
                },);
              });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("There is an error: " + snapshot.error.toString());
            } else {
              return Text("idk what happened");
            }
          });
    } else {
      return ListTile(title: Text('No results'),);
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> allSuggestions = List.empty(growable: true);

    if (query != '') {
      return FutureBuilder(future: FetchServices.getStockTickers(query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == []) {
                return ListTile(title: Text('No results'),);
              }
              for (SearchResult result in snapshot.data!) {
                if (allSuggestions.contains(result.tickerName!) == false) {
                  allSuggestions.add(result.tickerName!);
                }
              }

              print("SUGGESTIONS: " + allSuggestions.toString());

              return ListView.builder(itemCount: allSuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(allSuggestions[index]), onTap: () {
                      query = allSuggestions[index];
                      close(context, query);
                    },);
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return ListTile(title: Text('No results'),);
            } else {
              return ListTile(title: Text('No results'),);
            }
          });
    } else {
      return ListTile(title: Text('No results'),);
    }

    // @override
    // Widget? buildLeading(BuildContext context) {
    //   // TODO: implement buildLeading
    //   return IconButton(icon: Icon(Icons.arrow_back), onPressed: () {close(context, query);},);
    // }
    //
    // @override
    // Widget buildResults(BuildContext context) {
    //   // TODO: implement buildResults
    //   final List<String> allLocations = allCaliforniaPlaces.where(
    //         (place) => place.toLowerCase().contains(query.toLowerCase()),
    //   ).toList();
    //   return ListView.builder(itemCount: allLocations.length, itemBuilder: (context, index) => ListTile(title: Text(allLocations[index]), onTap: () {
    //     query = allLocations[index];
    //     close(context, query);
    //   },));
    // }
    //
    // @override
    // Widget buildSuggestions(BuildContext context) {
    //   // TODO: implement buildSuggestions
    //   final List<String> allSuggestions = allCaliforniaSuggestions.where(
    //         (place) => place.toLowerCase().contains(query.toLowerCase()),
    //   ).toList();
    //   return ListView.builder(itemCount: allSuggestions.length, itemBuilder: (context, index) => ListTile(title: Text(allSuggestions[index]), onTap: () {
    //     query = allSuggestions[index];
    //     close(context, query);
    //   },));
    // }
  }
  }