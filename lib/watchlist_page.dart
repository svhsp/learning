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
    String.fromEnvironment('SUPABASE_ANNON_KEY')
  );

  List<String> _tickerNames = [];
  Map<String, dynamic> _tickerPrices = {};
  Map<String, dynamic> _tickerChanges = {};

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
    if (stockData != null) {
      final tickerPrice = double.parse(stockData['Global Quote']['05. price']);
      final tickerChange = double.parse(stockData['Global Quote']['09. change']);
      setState(() {
        _tickerPrices[ticker] = tickerPrice;
        _tickerChanges[ticker] = tickerChange;
      });
    }
    _loadTickerNames();
  }

  double getTickerPrice(String ticker) {
    return _tickerPrices[ticker] ?? 0.0;
  }

  double getTickerChange(String ticker) {
    return _tickerChanges[ticker] ?? 0.0;
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