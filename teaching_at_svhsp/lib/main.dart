import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teaching_at_svhsp/common/loading_page_flow.dart';
import 'package:teaching_at_svhsp/pages/choose_location_screen.dart';
import 'package:teaching_at_svhsp/pages/loading_screen.dart';
import 'package:teaching_at_svhsp/pages/bay_area_place_search_screen.dart';
import 'package:teaching_at_svhsp/pages/show_location_time_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TeachingApp4SVHSP());
}

class TeachingApp4SVHSP extends StatelessWidget {
  const TeachingApp4SVHSP({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoadingScreen.pageName,
      title: 'Teaching App@SVHSP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        LoadingScreen.pageName: (context) =>
            LoadingScreen(pageFlow: LoadingPageFlow.loadStocks),
        ShowLocationTimeScreen.pageName: (context) => ShowLocationTimeScreen(),
        ChooseLocationScreen.pageName: (context) => ChooseLocationScreen(),
        BayAreaPlaceSearchScreen.pageName: (context) =>
            BayAreaPlaceSearchScreen(),
      },
    );
  }
}
