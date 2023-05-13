import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String flag; //url image
  late String urlApi; //location url for api
  late bool isDayTime; // true of false if daytime or not
  late String weatherApi; //location url for api
  late String tempf;
  late String condition;

  WorldTime({required this.location, required this.flag, required this.urlApi});

  Future<void> getTime() async {
    try {
      //convert time to usable map data
      var url = Uri.parse('https://worldtimeapi.org/api/timezone/$urlApi');
      var response = await http.get(url);
      Map data = jsonDecode(response.body);

      // get information from data
      String datetime = data['utc_datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      // DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //determine if daytime or nighttime
      isDayTime = now.hour > 7 && now.hour < 19;

      // set time property with function from installed intl package
      time = DateFormat.jm().format(now);

      //convert weather to usable map data
      var url1 = Uri.parse('http://api.weatherapi.com/v1/current.json?key=4ed5e4c2823c4c21bbb190622231802&q=$location&aqi=no');
      var response1 = await http.get(url1);
      Map dataWeather = jsonDecode(response1.body);

      tempf = dataWeather['current']['temp_f'].toString();

      condition = dataWeather['current']['condition']['text'];

    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
