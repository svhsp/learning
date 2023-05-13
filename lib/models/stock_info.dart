class StockInfo {
  late String tickerName;
  late String companyName;
  late String price;
  late String percentageChange;
  late Map data;

  StockInfo({required this.tickerName, required this.percentageChange, required this.price});
  StockInfo.search({required this.tickerName, required this.companyName});

}
