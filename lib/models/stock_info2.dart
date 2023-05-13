class StockInfo {
  final String symbol;
  final double price;
  final double changePercent;

  StockInfo({required this.symbol, required this.price, required this.changePercent});

  factory StockInfo.fromJson(Map<String, dynamic> json) {
    return StockInfo(
      symbol: json['01. symbol'],
      price: double.parse(json['05. price']),
      changePercent: double.parse(json['10. change percent'].replaceAll('%', '')),
    );
  }
}
