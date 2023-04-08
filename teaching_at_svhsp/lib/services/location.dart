import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class Location {
  String name; // name of a location
  late String time; // the time in that location
  String flag; // url to an asset flag icon
  String url; // location url for api endpoint
  bool isDayTime = false;

  Location({
    required this.name,
    required this.flag,
    required this.url,
  });

  Future<void> fetchTime() async {
    await Future.delayed(Duration(seconds: 1));
    http.Response response =
        await http.get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    Map data = jsonDecode(response.body);
    String datetime = data['datetime']; // local time in string
    String offset = data['utc_offset']; // e.g. +08:00 or -02:00

    DateTime now = DateTime.parse(datetime); // UTC time
    if (now.hour > 6 && now.hour < 20) {
      isDayTime = true;
    }
    time = DateFormat('hh:mm a')
        .format(now.add(Duration(hours: int.parse(offset.substring(0, 3)))));
  }
}
