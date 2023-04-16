class Stock {
  String ticker;
  late String company;
  double price;
  double changeInPercentage;
  Stock(
      {required this.ticker,
      required this.price,
      required this.changeInPercentage});

  static List<Stock> getStocks() {
    List<Stock> stocks = <Stock>[];
    stocks.add(Stock(
      ticker: "AAPL",
      price: 164.9,
      changeInPercentage: 1.56,
    ));
    stocks.add(Stock(
      ticker: "GOOGL",
      price: 103.73,
      changeInPercentage: 2.84,
    ));
    stocks.add(Stock(
      ticker: "SHOP",
      price: 47.94,
      changeInPercentage: 3.07,
    ));
    return stocks;
  }
}
