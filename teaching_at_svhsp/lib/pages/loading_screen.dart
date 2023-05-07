import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:logger/logger.dart';
import 'package:teaching_at_svhsp/common/loading_page_flow.dart';
import 'package:teaching_at_svhsp/pages/show_location_time_screen.dart';
import 'package:teaching_at_svhsp/pages/stock_list_screen.dart';
import 'package:teaching_at_svhsp/services/location.dart';
import 'package:teaching_at_svhsp/services/stock_manager.dart';

import '../models/stock.dart';

class LoadingScreen extends StatelessWidget {
  static const pageName = "/loading";
  final logger = Logger();
  final LoadingPageFlow pageFlow;
  static List<String> stockTickers = [];

  StockManager stockManager = StockManager();

  LoadingScreen({Key? key, required this.pageFlow}) : super(key: key);

  void doBackendWork(BuildContext context) async {
    if (pageFlow == LoadingPageFlow.loadDefaultLocation ||
        pageFlow == LoadingPageFlow.loadSelectedLocation) {
      fetchTimeByLocation(context);
    } else if (pageFlow == LoadingPageFlow.loadStocks) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        Map routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
        String newTicker = routeArgs['new_ticker'];
        if (!stockTickers.contains(newTicker)) {
          stockTickers.add(newTicker);
        }
      }

      fetchStock(context);
    }
  }

  void fetchStock(BuildContext context) async {
    List<Stock> stockList = await stockManager.fetchStocks(stockTickers);

    // route to home page to show the time & location.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => StockListScreen(stockList: stockList),
      ),
    );
  }

  void fetchTimeByLocation(BuildContext context) async {
    Location? selectedLocation;
    Map routeArgs = {};
    // If loading page is loaded during app start time, default location to
    // 'Berlin'.
    if (pageFlow == LoadingPageFlow.loadDefaultLocation) {
      selectedLocation =
          Location(name: 'Berlin', flag: 'germany.png', url: 'Europe/Berlin');
    } else {
      routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
      logger.log(Level.info, "routeArgs:$routeArgs");
      selectedLocation = Location(
          name: routeArgs['location'],
          flag: routeArgs['flag'],
          url: routeArgs['url']);
    }
    // call the world time API.
    await selectedLocation.fetchTime();
    // route to home page to show the time & location.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ShowLocationTimeScreen(),
        settings: RouteSettings(
          arguments: {
            'location': selectedLocation.name,
            'flag': selectedLocation.flag,
            'time': selectedLocation.time,
            'isDayTime': selectedLocation.isDayTime,
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    doBackendWork(context);
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: Center(
            child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 50.0,
        )),
      ),
    );
  }
}
