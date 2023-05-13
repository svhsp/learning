import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/pages/watch_list.dart';

import '../models/stock_info.dart';

class StockSearchDelegate extends SearchDelegate<List<StockInfo>> {
  final String apiUrl =
      'https://finnhub.io/api/v1/search?q=%s&token=cgu3hqpr01qu2uq5p73gcgu3hqpr01qu2uq5p740';
  final Function(StockInfo) onStockSelected;

  StockSearchDelegate({required this.onStockSelected});

  @override
  List<Widget> buildActions(BuildContext context) {
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
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WatchlistPage()),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<StockInfo>>(
      future: fetchStockResults(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final stockSuggestions = snapshot.data!;
          return ListView.builder(
            itemCount: stockSuggestions.length,
            itemBuilder: (context, index) {
              final stock = stockSuggestions[index];
              return ListTile(
                title: Text(stock.symbol),
                subtitle: Text(stock.description),
                onTap: () {
                  onStockSelected(stock);
                  close(context, [stock]);
                },
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return FutureBuilder<List<StockInfo>>(
        future: fetchStockSuggestions(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final topStocks = snapshot.data!;
            return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                final stock = topStocks[index];
                return ListTile(
                  title: Text(stock.symbol),
                  subtitle: Text(stock.description),
                  onTap: () {
                    onStockSelected(stock);
                    close(context, [stock]);
                  },
                );
              },
            );
          }
        },
      );
    } else {
      return Container();
    }
  }

  Future<List<StockInfo>> fetchStockSuggestions(String query) async {
    final url = apiUrl.replaceAll('%s', query);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['result'];

      final stockSuggestions = data
          .map(
            (item) => StockInfo.withDescription(
          symbol: item['symbol'],
          description: item['description'],
        ),
      )
          .toList();

      return stockSuggestions.sublist(0, 3);
    } else {
      throw Exception('Failed to fetch stock suggestions');
    }
  }
  Future<List<StockInfo>> fetchStockResults(String query) async {
    final url = apiUrl.replaceAll('%s', query);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> data = jsonData['result'];

      final stockSuggestions = data
          .map((item) =>
          StockInfo.withDescription(
            symbol: item['symbol'],
            description: item['description'],
          ))
          .toList();

      return stockSuggestions;
    } else {
      throw Exception('Failed to fetch stock suggestions');
    }
  }
}