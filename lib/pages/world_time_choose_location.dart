import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(urlApi: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(urlApi: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
    WorldTime(urlApi: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(urlApi: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(urlApi: 'America/Chicago', location: 'Chicago', flag: 'usa.png'), //wrong
    WorldTime(urlApi: 'America/New_York', location: 'New York', flag: 'usa.png'), // wrong
    WorldTime(urlApi: 'America/Phoenix', location: 'Phoenix', flag: 'usa.png'), //wrong
    WorldTime(urlApi: 'America/Toronto', location: 'Toronto', flag: 'canada.jpg'),  //wrong
    WorldTime(urlApi: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(urlApi: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(urlApi: 'Asia/Shanghai', location: 'Shanghai', flag: 'china.jpg'),
    WorldTime(urlApi: 'America/Costa_Rica', location: 'Costa Rica', flag: 'costarica.jpg'), //wrong
  ];

  //get time of selected location
  void updateTime(index) async {

    WorldTime instance = locations[index];
    //send back to home screen
    await instance.getTime();
    Navigator.pushNamed(context, '/world_time_home', arguments: {
      'urlApi': instance.urlApi,
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
      'tempf': instance.tempf,
      'condition': instance.condition,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Choose a Location'),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Card(
                  child: ListTile(
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: 'updated to ${locations[index].location}',
                          backgroundColor: Colors.lightGreen,
                        );
                        updateTime(index);
                      },
                      title: Text(locations[index].location),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('images/${locations[index].flag}'),
                      )
                  ),
                ),
              );
            }
        )
    );
  }
}
