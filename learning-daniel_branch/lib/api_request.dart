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