import 'package:flutter/material.dart';
import 'package:stonks/models/stock_info.dart';
import 'package:stonks/services/suggested_stocks_fetcher.dart';
import 'global_var.dart';
import 'package:stonks/services/all_stocks_fetcher.dart';
class searchDelegate extends SearchDelegate<String> {
  late final List<String> allStocks;
  final List<String> suggestedStocks;

  searchDelegate({required this.allStocks, required this.suggestedStocks});

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
      icon: Icon(Icons.arrow_back),
      onPressed:  () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    AllStockFetcher fetcher = AllStockFetcher(query);
    if(query==''){
      return Container();
    }
    List<String> results = List.empty(growable: true);
    return FutureBuilder<List<Stock>>(
        future: fetcher.lookAllSymbol(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            for (Stock i in snapshot.data!) {
              results.add(i.symbol);
            }

            return Scrollbar(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(results[index]),
                    trailing: Text(results[index]),
                    onTap: () {
                      query = results[index];
                      close(context, query);
                    },
                  );
                },
                itemCount: snapshot.data!.length,
              ),
              );

          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    StockNameFetcher fetcher = StockNameFetcher(query);
    if(query==''){
      return Container();
    }
    List<String> results = List.empty(growable: true);
    return FutureBuilder<List<Stock>>(
        future: fetcher.lookupSymbol(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            for (Stock i in snapshot.data!) {
              results.add(i.symbol);
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(results[index]),
                  trailing: Text(results[index]),
                  onTap: () {
                    query = results[index];
                    close(context, query);
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
        });
  }

}