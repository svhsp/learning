class Stock {
  String ticker_name;
  String price;
  String change;

  @override
  String toString() {
    return "ticker_name: " + ticker_name + " price:" + price + " change: "+ change;
  }

  Stock(this.ticker_name, this.price, this.change);
}