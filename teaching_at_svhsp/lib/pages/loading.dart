import 'package:flutter/material.dart';
import 'package:teaching_at_svhsp/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:teaching_at_svhsp/pages/show_location_time.dart';
import 'package:logger/logger.dart';

class Loading extends StatefulWidget {
  static const pageName = "/loading";
  final String previousPage;

  const Loading({Key? key, required this.previousPage}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Map routeArgs = {};
  final logger = Logger();

  /// Invoke world_time api asynchronously and then forward to Home page to show
  /// the time.
  void fetchAndShowTime() async {
    Location? selectedLocation;
    // If loading page is loaded during app start time, default location to
    // 'Berlin'.
    if (widget.previousPage == '/') {
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
        builder: (context) => const ShowLocationTime(),
        settings: RouteSettings(arguments: {
          'location': selectedLocation.name,
          'flag': selectedLocation.flag,
          'time': selectedLocation.time,
          'isDayTime': selectedLocation.isDayTime,
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    fetchAndShowTime();
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
