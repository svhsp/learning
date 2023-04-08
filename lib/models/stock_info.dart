class StockInfo {
  late final String symbol;
  late final String name;
  late final double price;
  late final double change;

  StockInfo({required this.symbol, required this.name, required this.price, required this.change});

  static List<StockInfo> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => StockInfo(
      symbol: json['symbol'],
      name: json['name'],
      price: json['price'],
      change: json['change'],
    )).toList();
  }

}
