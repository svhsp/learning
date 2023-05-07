
import 'package:flutter/material.dart';

class SearchLocations extends SearchDelegate<String> {
  final List<String> Stocks;
  final List<String> MainStocks;

  SearchLocations({required this.Stocks, required this.MainStocks});

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
    final List<String> allLocations = Stocks.where((Stocks) =>Stocks.toLowerCase().contains(query.toLowerCase(),),).toList();

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
    final List<String> bayAreaSuggested = MainStocks.where((Stocks) => Stocks.toLowerCase().contains(query.toLowerCase(),),).toList();

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