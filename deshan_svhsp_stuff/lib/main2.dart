import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:paginated_search_bar/paginated_search_bar.dart';
import 'package:endless/endless.dart';

class ExampleItem {
  final String title;

  ExampleItem({
    required this.title,
  });
}

class ExampleItemPager {
  int pageIndex = 0;
  final int pageSize;

  ExampleItemPager({
    this.pageSize = 20,
  });

  List<ExampleItem> nextBatch(List<String> results) {
    List<ExampleItem> batch = [];

    for (int i = 0; i < results.length; i++) {
      batch.add(ExampleItem(title: results[i].toString()));
    }
    pageIndex += 1;
    return batch;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ExampleItemPager pager = ExampleItemPager();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            // padding: const EdgeInsets.only(top: 100),
            // alignment: Alignment.topCenter,
            child: SizedBox(
                width: 600,
                child: PaginatedSearchBar<ExampleItem>(
                  hintText: 'Search for a stock',
                  emptyBuilder: (context) {
                    return const Text("I'm an empty state!");
                  },
                  paginationDelegate: EndlessPaginationDelegate(
                    pageSize: 20,
                    maxPages: 3,
                  ),
                  onSearch: ({
                    required pageIndex,
                    required pageSize,
                    required searchQuery,
                  }) async {
                    return Future.delayed(const Duration(milliseconds: 500), () async {
                      if (searchQuery == "empty") {
                        return [];
                      }

                      final dio = Dio();
                      final response = await dio.get("https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=" + searchQuery + "&apikey=G4UJ9ECYT8N1K1O6");
                      Map<String, dynamic> queryResults = response.data;
                      List<dynamic> results = queryResults['bestMatches'];
                      List<String> resultStockNames = List.empty(growable: true);

                      for (dynamic stock in results) {
                        resultStockNames.add(stock['1. symbol'].toString());
                      }

                      if (pageIndex == 0) {
                        pager = ExampleItemPager();
                      }

                      return pager.nextBatch(resultStockNames);
                    });
                  },
                  itemBuilder: (
                      context, {
                        required item,
                        required index,
                      }) {
                    return Text(item.title);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}