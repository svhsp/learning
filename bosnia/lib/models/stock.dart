class Stock {
  final String ticker;
  final String price;
  final String percentageChange;

  Stock({
    required this.ticker,
    required double price,
    required double percentageChange,
  })  : price = price.toString(),
        percentageChange = percentageChange.toString();
}