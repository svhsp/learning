import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:teaching_at_svhsp/pages/choose_location.dart';
import 'package:teaching_at_svhsp/pages/show_location_time.dart';
import 'package:teaching_at_svhsp/pages/loading.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Loading.pageName,
      title: 'WorldTimer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Loading.pageName: (context) => Loading(previousPage: '/'),
        ShowLocationTime.pageName: (context) => ShowLocationTime(),
        ChooseLocation.pageName: (context) => ChooseLocation(),
      },
    );
  }
}
