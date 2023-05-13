import 'package:flutter/material.dart';

import '../models/stock_info.dart';
import '../services/stock_fetcher.dart';
import 'loading.dart';

class StockSearch extends SearchDelegate<String> {
  final List<String> all_stocks;
  final List<String> suggested_stocks;

  StockSearch({required this.all_stocks, required this.suggested_stocks});

  StockFetcher searcher = StockFetcher();

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

    if (query == ''){
      return Container();
    }

    return FutureBuilder<List<StockInfo>>(
        future: searcher.searchStocks(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].tickerName),
                  trailing: Text(snapshot.data![index].companyName),
                  onTap: () {
                    query = snapshot.data![index].tickerName;
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) =>
                            Loading(app: 'stock'),
                        settings: RouteSettings(arguments: {
                          'new_ticker': query,
                        }),
                      ),
                    );
                  },
                );
              },
              itemCount: snapshot.data!.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
        );
    }
    }


