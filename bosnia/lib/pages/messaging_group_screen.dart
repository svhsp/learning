import 'package:bosnia/pages/messaging_groups_screen.dart';
import 'package:flutter/material.dart';
import '../reusable_widgets.dart';
import 'messaging_login_screen.dart';
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

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  final TextEditingController _messageTextController = TextEditingController();

  String AMPMFormat (DateTime date) {
    return date.hour/12 < 1 ? "AM" : "PM";
  }

  String getDateTimeDiff(DateTime date) {
    if ((DateTime.now().difference(date).inDays).abs() < 1) {
      print("${DateTime.now().day}:${date.day}");
      return "Today at ${date.hour%12}:${date.minute} ${AMPMFormat(date)}";
    }
    if ((DateTime.now().difference(date).inDays).abs() < 2) {
      print("${DateTime.now().day}:${date.day}");
      return "Yesterday at ${date.hour%12}:${date.minute} ${AMPMFormat(date)}";
    } else {
      print("${DateTime.now().day}:${date.day}");
      return "${date.month}/${date.day}/${date.year} ${date.hour%12}:${date.minute} ${AMPMFormat(date)}";
    }
  }

  void SendMessage()  {
    String messageValue = _messageTextController.text;
    _messageTextController.clear();
    print(selectedGroup.id);
    Timestamp currTime = Timestamp.now();
    db.collection(selectedGroup.id).add(
    {
      "datetime" : currTime,
      "email" : email,
      "value" : messageValue,
    });
    selectedGroup.messages.add(Message(messageEmail: email, messageDateTime: currTime.toDate(), messageValue: messageValue));
    if (selectedGroup.messages[0].messageEmail == "temporary") {
      selectedGroup.messages.removeAt(0);
      db.collection(selectedGroup.id).doc("Temporary Start Message").delete();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: hexStringColor("A89B9D"),
        elevation: 0,
        centerTitle: true,
        title: Text(
          selectedGroup.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: hexStringColor("CFCFEA"),
        ),
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Container(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 15, bottom: 0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ListView.builder(
                    itemCount: selectedGroup.messages.length,
                    itemBuilder: (context, idx) {
                      return Card(
                        color: selectedGroup.messages[idx].messageEmail == email ? hexStringColor("c7ffc7") :  hexStringColor("cccccc"),
                        child: ListTile(
                          title: Text("${usernames[selectedGroup.messages[idx].messageEmail]}   ${getDateTimeDiff(selectedGroup.messages[idx].messageDateTime)}", style: TextStyle(fontSize: 10, color: Colors.black.withOpacity(0.5)),),
                          subtitle: Text(selectedGroup.messages[idx].messageValue),
                        )
                      );
                    }
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.0,
                        0.1,
                      ],
                      colors: [
                        // Colors.transparent,
                        // Colors.orange,
                        Color.fromRGBO(207, 207, 234, 0.5),
                        Color(0xFFCFCFEA),
                      ],
                    )
                ),
                child: TextField(
                  controller: _messageTextController,
                  enableSuggestions: true,
                  autocorrect: true,
                  cursorColor: Colors.grey,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: "Message",
                    labelStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.4),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        SendMessage();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}