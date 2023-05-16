import 'package:bosnia/models/group.dart';
import 'package:bosnia/models/loading.dart';
import 'package:bosnia/models/message.dart';
import 'package:bosnia/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:bosnia/firebase_constants.dart';
import 'package:bosnia/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/group_fetcher.dart';
import 'messaging_login_screen.dart';

bool isReady = false;
Group selectedGroup = Group(id: "", name: "", messages: []);
final db = FirebaseFirestore.instance;
Map<String, String> usernames = {};

class GroupsListPage extends StatefulWidget {
  const GroupsListPage({Key? key}) : super(key: key);

  @override
  State<GroupsListPage> createState() => _GroupsListPageState();
}

class _GroupsListPageState extends State<GroupsListPage> {
  late List<Group> Groups = [];

  Future<void> initUsers() async{
    usernames = await GroupFetcher.getUsers(usernames);
  }

  void initAll() {
    initUsers();
    Future<List<Group>> futureGroups = GroupFetcher.getGroups();
    Groups.clear();
    futureGroups.then((value) {
      for (int i = 0; i < value.length; i++) {
        Groups.add(value[i]);
      }
      print("completed");
      print(Groups);
      setState(() {
        isReady = true;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initUsers();
    Future<List<Group>> futureGroups = GroupFetcher.getGroups();
    Groups.clear();
    futureGroups.then((value) {
      for (int i = 0; i < value.length; i++) {
        Groups.add(value[i]);
      }
      print("completed");
      print(Groups);
      setState(() {
        isReady = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: hexStringColor("A89B9D"),
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Groups",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(icon:  const Icon(Icons.add), tooltip: 'Add a Group',
              onPressed: () {
                Navigator.pushNamed(context, '/add').then((value) => initAll());
              },)
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: hexStringColor("CFCFEA"),
          ),
          child: isReady? Container(
            padding: const EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 90),
            decoration: BoxDecoration(
              color: hexStringColor("CFCFEA"),
            ),
            child: ListView.builder(
              itemCount: Groups.length,
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
              itemBuilder: (context, idx) {
                return Card(
                  color: hexStringColor("4A4063"),
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      selectedGroup = Groups[idx];
                      Navigator.pushNamed(context, '/group').then((value) => initAll());
                    },
                    child: SizedBox(
                      child: ListTile(
                          title: Text(Groups[idx].name, style: TextStyle(color: Colors.white)),
                          subtitle: Text(Groups[idx].messages[Groups[idx].messages.length-1].messageValue, style: TextStyle(color: Colors.white.withOpacity(0.7)))
                      ),
                    ),
                  ),
                );
              },
            )
          ) : Center(
              child: Loading().load
        ),
      ),
    );
  }
}