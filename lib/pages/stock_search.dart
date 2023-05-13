import 'package:flutter/material.dart';

import '../models/stock_info.dart';
import '../services/stock_fetcher.dart';

class StockSearch extends SearchDelegate<String> {
  final List<String> all_stocks;
  final List<String> suggested_stocks;

  StockSearch({required this.all_stocks, required this.suggested_stocks});

  @override
  String get searchFieldLabel => 'Search for a stock';

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
    final List<String> list_stocks = all_stocks
        .where((element) => element.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: list_stocks.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(list_stocks[index]),
          onTap: () {
            query = list_stocks[index];
            close(context, query);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<StockInfo> allSuggestions = List.empty(growable: true);
    StockFetcher searcher = StockFetcher();

    if (query != '') {
      return FutureBuilder(
          future: searcher.fetchStocks([]),   //fix
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("TYPE: " + snapshot.data!.runtimeType.toString());
              for (StockInfo result in snapshot.data!) {
                if (allSuggestions.contains(result) == false) {
                  allSuggestions.add(result);
                }
              }

              print("SUGGESTIONS: " + allSuggestions.toString());

              return ListView.builder(
                  itemCount: allSuggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(allSuggestions[index].tickerName),
                        trailing: Text(allSuggestions[index].companyName),
                      onTap: () {
                        query = allSuggestions[index].tickerName;
                        close(context, query);
                      },
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("There is an error: " + snapshot.error.toString());
            } else {
              return Text("Contact Support");
            }
          });
    } else {
      return ListTile(
        title: Text('No results'),
      );
    }
  }
}
