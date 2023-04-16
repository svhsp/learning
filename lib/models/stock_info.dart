class Stock {
  final String symbol;
  final String name;
  final double price;
  final double change;

  Stock({
    required this.symbol,
    required this.name,
    required this.price,
    required this.change,
  });

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
      symbol: json['1. symbol'],
      name: json['2. name'],
      price: double.parse(json['4. close']),
      change: double.parse(json['9. change']),
    );
  }
}