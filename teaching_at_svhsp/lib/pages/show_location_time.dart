import 'package:flutter/material.dart';
import 'package:teaching_at_svhsp/pages/choose_location.dart';

class ShowLocationTime extends StatefulWidget {
  static const pageName = "/home_page";
  const ShowLocationTime({Key? key}) : super(key: key);

  @override
  State<ShowLocationTime> createState() => _ShowLocationTimeState();
}

class _ShowLocationTimeState extends State<ShowLocationTime> {
  Map routeArgs = {};

  @override
  Widget build(BuildContext context) {
    routeArgs = ModalRoute.of(context)!.settings.arguments as Map;
    String bgImageName = routeArgs['isDayTime'] ? 'day.png' : 'night.png';
    Color? bgColor = routeArgs['isDayTime'] ? Colors.blue : Colors.indigo[700];
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/$bgImageName'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(ChooseLocation.pageName);
                  },
                  icon: Icon(
                    Icons.edit_location,
                  ),
                  label: Text('Edit Location'),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      routeArgs['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  routeArgs['time'],
                  style: TextStyle(
                    fontSize: 56.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
