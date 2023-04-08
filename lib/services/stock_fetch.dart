import 'package:learning/models/stock_info.dart';

class StockFetch {
  static Future<List<Stock>> fetchStocks() async {
    // Make an API call to get real-time stock data
    // For now, return a hardcoded list of Stock objects
    return [
      Stock(
        tickerName: 'AAPL',
        company: 'Apple Inc.',
        price: 133.5,
        change: -0.2,
      ),
      Stock(
        tickerName: 'GOOG',
        company: 'Alphabet Inc.',
        price: 2213.5,
        change: 0.5,
      ),
      Stock(
        tickerName: 'MSFT',
        company: 'Microsoft Corporation',
        price: 249.9,
        change: -0.1,
      ),
      Stock(
        tickerName: 'TSLA',
        company: 'Tesla Inc.',
        price: 708.0,
        change: 0.8,
      ),
    ];
  }
}