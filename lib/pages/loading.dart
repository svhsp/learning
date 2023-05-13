
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:learning/pages/stock_list.dart';
import 'package:learning/pages/world_time_home.dart';
import 'package:learning/services/stock_fetcher.dart';
import 'package:learning/services/world_time.dart';

import '../models/stock_info.dart';




class Loading extends StatefulWidget {
  String app;

  Loading({Key? key, required this.app}) : super(key: key);


  List<String> tickers = ['AAPL', 'GOOGL'];

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Map data = {};
  List<StockInfo> listStockInfo = [];
  StockFetcher stockFetcher = StockFetcher();

  //ASYNC API CALL with getStockInfo
  void verifyApp(BuildContext context) async {
    if (widget.app == 'stock') {
      getStockInfo(widget.tickers);
    } else if (widget.app == 'world_time') {
      fetchWorldTime();
    }
  }


  void getStockInfo(List<String> tickers) async {
    listStockInfo = await stockFetcher.fetchStocks(tickers);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => StockListPage(listStockInfo: listStockInfo),
      ),
    );
  }


  void fetchWorldTime() async {
    WorldTime? instance;
    if (ModalRoute.of(context)!.settings.arguments == null) {
      instance = WorldTime(
          location: 'Dubai', flag: 'Dubai.png', urlApi: 'Asia/Dubai');
    } else {
      data = ModalRoute.of(context)!.settings.arguments as Map;
      instance = WorldTime(
          location: data['location'],
          flag: data['flag'],
          urlApi: data['urlApi']);
    }
    await instance.getTime();
    await Future.delayed(const Duration(seconds: 2));
    Navigator.popAndPushNamed(context, '/world_time_home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
      'tempf': instance.tempf,
      'condition': instance.condition,
    });
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    verifyApp(context);
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: const SafeArea(
        child: Center(
            child: SpinKitDualRing(
              color: Colors.white,
              size: 50.0,
            )),
      ),
    );
  }
}

