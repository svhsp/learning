

// class StockInfo {
//   final String tickerName;
//   // final String company;
//   final double price;
//   final double percentChange;
//
//   StockInfo({
//     required this.tickerName,
//     // required this.company,
//     required this.price,
//     required this.percentChange,
//   });
// }

class StockInfo {
  final String tickerName;
  final String price;
  final String percentChange;

  StockInfo({
    required this.tickerName,
    required double price,
    required double percentChange,
  })  : price = price.toString(),
        percentChange = percentChange.toString();
}