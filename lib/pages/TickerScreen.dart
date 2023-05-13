import 'package:flutter/material.dart';
import '../models/stock.dart';
import '../services/services.dart';

class TickerScreen extends SearchDelegate {
  StockManager stockManager = new StockManager();

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
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query == '') {
      return Container();
    }

    return FutureBuilder<List<Stock>>(
      future: stockManager.lookupSymbol(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].ticker),
                trailing: Text(snapshot.data![index].company),
                onTap: () {
                  query = snapshot.data![index].ticker;
                  selectTicker(context, query);
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
  void selectTicker(BuildContext context, String ticker) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            LoadingScreen(pageFlow: LoadingPageFlow.loadStocks),
        settings: RouteSettings(arguments: {
          'new_ticker': ticker,
        }),
      ),
    );
  }
}
