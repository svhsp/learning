import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/reusable_widgets.dart';


class HomePage extends StatefulWidget {
  List<String> groups = [];


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.lightGreen,
            elevation: 0,
            centerTitle: true,
            title: Text('Hello')
        ),
        body: Center(
            child: ElevatedButton(child: Text('LOGOUT'), onPressed: () {
              authService.signOut();
            }))
    );
  }
}