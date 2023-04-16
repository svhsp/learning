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
  final supabase = SupabaseClient(
    'https://tuduixqbwmummppelbgt.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR1ZHVpeHFid211bW1wcGVsYmd0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODA4OTk3MzksImV4cCI6MTk5NjQ3NTczOX0.0I3hFGhrwYB8A5tpL78UW7JJJbvPRwLnfCvDwEzBMIE',
  );
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
                          // Update _searchResult with new data
                          setState(() => {
                            _searchResult = {
                              '01. symbol': _searchResult!['01. symbol'],
                              '05. price': _searchResult!['05. price'],
                              '02. open': _searchResult!['02. open'],
                              '03. high': _searchResult!['03. high'],
                              '04. low': _searchResult!['04. low'],
                            },
                          });

                          Navigator.pop(context);
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