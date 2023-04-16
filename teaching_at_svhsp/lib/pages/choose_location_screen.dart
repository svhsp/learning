import 'package:flutter/material.dart';
import 'package:teaching_at_svhsp/services/location.dart';
import 'package:teaching_at_svhsp/widgets/location_card.dart';

class ChooseLocationScreen extends StatefulWidget {
  static const pageName = "/choose_location";
  const ChooseLocationScreen({Key? key}) : super(key: key);

  @override
  State<ChooseLocationScreen> createState() => _ChooseLocationScreenState();
}

class _ChooseLocationScreenState extends State<ChooseLocationScreen> {
  List<Location> locations = [
    Location(url: 'Europe/London', name: 'London', flag: 'uk.png'),
    Location(url: 'Europe/Berlin', name: 'Athens', flag: 'greece.png'),
    Location(url: 'Africa/Cairo', name: 'Cairo', flag: 'egypt.png'),
    Location(url: 'America/Chicago', name: 'Chicago', flag: 'usa.png'),
    Location(url: 'Asia/Shanghai', name: 'Shanghai', flag: 'cn.png'),
  ];

  @override
  void initState() {
    super.initState();
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
        itemBuilder: (context, index) {
          return LocationCard(location: locations[index]);
        },
      ),
    );
  }
}
