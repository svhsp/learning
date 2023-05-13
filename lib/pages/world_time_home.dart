import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  String tempf = '';

  @override
  Widget build(BuildContext context) {
    //recieve data
    try {
      data = data.isNotEmpty
          ? data
          : ModalRoute.of(context)!.settings.arguments as Map;
      tempf = data['tempf'];
    } catch (e) {
      data = data;
    }
    print(data);

    String location = data['location']!;

    //set background using ternary operater '?'
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('world_time_lib/images/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                    await Navigator.pushNamed(context, '/world_time_location');
                    setState(() {
                      data = {
                        'location': result['location'],
                        'flag': result['flag'],
                        'isDayTime': result['isDayTime'],
                        'tempf': result['tempf'],
                        'tempc': result['tempc'],
                        'condition': result['condition'],
                        'time': result['time'],
                      };
                    });
                  },
                  icon: Icon(Icons.edit_location, color: Colors.grey[300]),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[300], ///////
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 40,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 80,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 50),
                Text('${data['tempf']} °F',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    )),
                SizedBox(height: 50),
                Text('${data['condition']}',
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
