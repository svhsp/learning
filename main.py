main.dart
import 'package:flutter/material.dart';
import 'search_page.dart';
import 'watchlist_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Viewer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WatchListPage(),
        '/search': (context) => SearchPage(),
      },
    );
  }
}


search_page.dart
import 'package:flutter/material.dart';
import 'package:stock_tracker/watchlist_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'api_request.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = '';
  Map<String, dynamic>? _searchResult;

  Future<void> _searchStock() async {
    try {
      final result = await fetchStockData(_searchQuery);
      setState(() {
        _searchResult = result;
      });
    } catch (e) {
      setState(() {
        _searchResult = null;
      });
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                hintText: 'Enter stock ticker symbol',
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _searchQuery.isNotEmpty ? _searchStock : null,
              child: const Text('Search'),
            ),
            const SizedBox(height: 16),
            if (_searchResult != null)
              Column(
                children: [
                  Text(
                    '${_searchResult!['01. symbol']}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Price'),
                      Text('${_searchResult!['05. price']}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Open'),
                      Text('${_searchResult!['02. open']}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('High'),
                      Text('${_searchResult!['03. high']}'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Low'),
                      Text('${_searchResult!['04. low']}'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text('Add to Watchlist'),
                    onPressed: () async {
                      final supabase = SupabaseClient(
                        'https://tuduixqbwmummppelbgt.supabase.co',
                        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR1ZHVpeHFid211bW1wcGVsYmd0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODA4OTk3MzksImV4cCI6MTk5NjQ3NTczOX0.0I3hFGhrwYB8A5tpL78UW7JJJbvPRwLnfCvDwEzBMIE',
                      );

                      final response = await supabase.from('tickers').select().eq('name', _searchResult!['01. symbol']).execute();
                      if (response.status == 200 && response.data.length > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Ticker already exists in watchlist.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } else {
                        final insertResponse = await supabase.from('tickers').insert({'name': _searchResult!['01. symbol']}).execute();
                        if (insertResponse.status != 201) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error adding ticker to watchlist.'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        } else {
                          Navigator.pop(context);
                          setState(() {});
                        }
                      }
                    },

                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}


watchlist_page.dart
import 'package:flutter/material.dart';
import 'package:stock_tracker/api_request.dart';
import 'package:supabase/supabase.dart';

class WatchListPage extends StatefulWidget {
  @override
  _WatchListPageState createState() => _WatchListPageState();
}
class _WatchListPageState extends State<WatchListPage> {
  final supabase = SupabaseClient(
    'https://tuduixqbwmummppelbgt.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR1ZHVpeHFid211bW1wcGVsYmd0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODA4OTk3MzksImV4cCI6MTk5NjQ3NTczOX0.0I3hFGhrwYB8A5tpL78UW7JJJbvPRwLnfCvDwEzBMIE',
  );

  List<String> _tickerNames = [];
  List<String> _tickerPrices = [];
  List<String> _tickerChanges = [];

  @override
  void initState() {
    super.initState();
    _loadTickerNames();
  }

  Future<void> _loadTickerNames() async {
    final response = await supabase.from('tickers').select('name').execute();
    if (response.status == 200) {
      final tickerNames = response.data.cast<Map<String, dynamic>>().map((ticker) => ticker['name'].toString()).toList().cast<String>();
      setState(() {
        _tickerNames = tickerNames;
        build(context);
      });
    } else {
      // handle error
    }
  }


  Future<void> _removeTicker(String ticker) async {
    final response = await supabase.from('tickers').delete().eq('name', ticker).execute();
    if (response.status != 200) {
      // handle error
    }
    _loadTickerNames();
  }

  Future<void> _updateTickerPrice(String ticker) async {
    final stockData = await fetchStockData(ticker);
      //final response = await supabase.from('tickers').update({'price': stockData['05. price']}).eq('ticker', ticker).execute();
      //if (response.status != 200) {
        // handle error
      //}
      _loadTickerNames();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _tickerNames.length,
        itemBuilder: (context, index) {
          _loadTickerNames();
          final ticker = _tickerNames[index];
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ticker),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _removeTicker(ticker);
              },
            ),
            onTap: () {
              _updateTickerPrice(ticker);
            },
          );
        },
      ),

    );
  }
}

api_request.dart
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchStockData(String ticker) async {
  final url =
      'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$ticker&apikey=G4UJ9ECYT8N1K1O6';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return jsonData['Global Quote'];
  } else {
    throw Exception('Failed to load stock data');
  }
}
