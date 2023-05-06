class SearchResult {
  String? tickerName;
  String? companyName;

  SearchResult(this.tickerName, this.companyName);

  @override
  String toString() {
    return "ticker_name: " + tickerName! + " company name:" + companyName!;
  }
}