// import 'package:flutter/material.dart';
//
// import '../models/stock_info.dart';
// import '../services/stock_fetcher.dart';
//
// class WatchlistPage extends StatefulWidget {
//   @override
//   _WatchlistPageState createState() => _WatchlistPageState();
// }
//
// class _WatchlistPageState extends State<WatchlistPage> {
//   final List<String> _defaultSymbols = ['GOOG', 'AAPL', 'TSLA'];
//   List<String> _symbols = [];
//   List<StockInfo> _filteredStocks = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _symbols = _defaultSymbols;
//     _fetchStocks();
//   }
//
//   Future<void> _fetchStocks() async {
//     final stocksInfo = await StockFetcher.fetchStocks(_symbols);
//     setState(() {
//       _filteredStocks = stocksInfo;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Stock Watchlist'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () async {
//               final selectedSymbol = await showSearch(
//                 context: context,
//                 delegate: StockSearchDelegate(_symbols),
//               );
//               if (selectedSymbol != null) {
//                 setState(() {
//                   _symbols = [selectedSymbol];
//                 });
//                 await _fetchStocks();
//               }
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: DataTable(
//           columns: [
//             DataColumn(label: Text('Symbol')),
//             DataColumn(label: Text('Price')),
//             DataColumn(label: Text('Change')),
//           ],
//           rows: _filteredStocks.map((stock) => DataRow(
//             cells: [
//               DataCell(Text(stock.symbol)),
//               DataCell(Text(stock.price.toStringAsFixed(2))),
//               DataCell(Text(stock.change.toStringAsFixed(2))),
//             ],
//           )).toList(),
//         ),
//       ),
//     );
//   }
// }
//
// class StockSearchDelegate extends SearchDelegate<String> {
//   final List<String> symbols;
//
//   StockSearchDelegate(this.symbols);
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     final selectedSymbol = symbols.firstWhere((symbol) => symbol == query.toUpperCase());
//     if (selectedSymbol != null) {
//       close(context, selectedSymbol);
//     }
//     return Center(
//       child: Text(
//         selectedSymbol != null ? 'Selected symbol: $selectedSymbol' : 'Symbol not found',
//       ),
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestions = symbols.where((symbol) => symbol.startsWith(query.toUpperCase())).toList();
//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (BuildContext context, int index) {
//         return ListTile(
//           title: Text(suggestions[index]),
//           onTap: () {
//             close(context, suggestions[index]);
//           },
//         );
//       },
//     );
//   }
// }