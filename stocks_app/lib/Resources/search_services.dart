import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Widgets/EmailVerificationScreen.dart';
import '../Resources/firebase_options.dart';
import '../Resources/firebase_constants.dart';
import '../pages/stockpage.dart';

class SearchStock extends SearchDelegate {

  final List<String> stocks;
  final List<String> suggestedStocks;

  SearchStock({required this.stocks, required this.suggestedStocks});

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
    final List<String> foundStock = stocks.where(
          (stock) => stock.toLowerCase().contains(
        query.toLowerCase(),
      ),
    ).toList();
    return ListView.builder(
        itemCount: foundStock.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(foundStock[i]),
          onTap: () {
            query = foundStock[i];
            close(context, query);
            stockIds.add(query);
          },
        )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> searchedSuggestedLocations = suggestedStocks.where(
          (suggestedStock) => suggestedStock.toLowerCase().contains(
        query.toLowerCase(),
      ),
    ).toList();
    return ListView.builder(
        itemCount: searchedSuggestedLocations.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(searchedSuggestedLocations[i]),
          onTap: () {
            query = searchedSuggestedLocations[i];
            close(context, query);
            stockIds.add(query);
          },
        )
    );
  }

}