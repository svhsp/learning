class StockInfo {
  late final String symbol;
  late final String name;
  late final double price;
  late final double change;

  StockInfo({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
  });

  factory StockInfo.fromJson(Map<String, dynamic> json) {
    return StockInfo(
      symbol: json['symbol'],
      name: json['name'],
      price: json['price'].toDouble(),
      change: json['change'].toDouble(),
    );
  }

  static List<StockInfo> fromJsonList(List<dynamic> jsonList) {
    List<StockInfo> stocks = [];
    for (var json in jsonList) {
      stocks.add(StockInfo.fromJson(json));
    }
    return stocks;
  }
}
