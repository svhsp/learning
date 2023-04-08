class Stock {
  String ticker;
  String company;
  double price;
  double changeInPercentage;
  Stock(
      {required this.ticker,
      required this.company,
      required this.price,
      required this.changeInPercentage});

  static List<Stock> getStocks() {
    List<Stock> stocks = <Stock>[];
    stocks.add(Stock(
      ticker: "AAPL",
      company: "Apple Inc",
      price: 164.9,
      changeInPercentage: 1.56,
    ));
    stocks.add(Stock(
      ticker: "GOOGL",
      company: "Alphabet Inc",
      price: 103.73,
      changeInPercentage: 2.84,
    ));
    stocks.add(Stock(
      ticker: "SHOP",
      company: "Shopify Inc",
      price: 47.94,
      changeInPercentage: 3.07,
    ));
    return stocks;
  }
}
