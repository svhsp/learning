class Stock {
  String? ticker_name;
  String? price;
  String? change;

  Stock.fromJson(Map<String, dynamic> json) {
    ticker_name = json['01. symbol'];
    price = json['05. price'];
    change = json['10. change percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['01. symbol'] = this.ticker_name;
    data['05. price'] = this.price;
    data['10. change percent'] = this.change;
    return data;
  }

  @override
  String toString() {
    return "ticker_name: " + ticker_name! + " price:" + price! + " change: "+ change!;
  }

  Stock(this.ticker_name, this.price, this.change);
}