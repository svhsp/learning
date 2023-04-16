class Stock {
  late String ticker;
  late String price = "103.73";
  late String percentageChange = "2.81";

  Stock({required this.ticker, required this.price, required this.percentageChange});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(
        ticker: json["symbol"], percentageChange: json["change percent"], price: json["price"].toDouble());
  }
}