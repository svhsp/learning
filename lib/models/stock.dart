class Stock {
  String ticker;
  late String company;
  late double price;
  late double changeInPercentage;
  Stock(this.ticker, this.price, this.changeInPercentage);
  Stock.Symbol(this.ticker, this.company);
}