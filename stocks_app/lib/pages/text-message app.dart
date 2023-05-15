import 'dart:js_util';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Widgets/EmailVerificationScreen.dart';
import '../Resources/firebase_options.dart';
import '../Resources/firebase_constants.dart';

class Groups extends StatefulWidget {
  const Groups({super.key, required this.title});
  final String title;

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  final textCont = TextEditingController();
  String groupN = "6EPfBv5vz23i2KH0rFvr";
  String regUsername = "micheal jackson";
  CollectionReference messages = FirebaseFirestore.instance.collection('6EPfBv5vz23i2KH0rFvr');
  List<dynamic> interpretedMessages = [];

  void updateMessages () async {
    interpretedMessages = [];
    var querySnapshot = await messages.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Object? data = queryDocumentSnapshot.data();
      try{
        if (data != null){
          if (data != {}){
            interpretedMessages.add(data);
          }x
        }
      } catch (e){
        DateTime currentPhoneDate = DateTime.now();
        Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);
        DateTime myDateTime = myTimeStamp.toDate();
        interpretedMessages.add({"username": "Error","sendtime": myDateTime, "message" : e});
      }
    }
    print(interpretedMessages);
  }

  void initState() {
    super.initState();
    updateMessages();
  }

  Future sendMessage() async{
    DateTime currentPhoneDate = DateTime.now();
    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);
    DateTime myDateTime = myTimeStamp.toDate();
    try {
      FirebaseFirestore.instance.collection('6EPfBv5vz23i2KH0rFvr').add({"username": regUsername, "sendtime": myDateTime, "message": textCont.text});
      textCont.text = "";
      updateMessages();
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Color.fromRGBO(32, 32, 32, 1),
      ),
      home: Scaffold(
        body: Center(
          child:
            Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width*0.2,
                    color: Color.fromRGBO(69,69,69,1),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width*0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text("")),
                                DataColumn(label: Text("")),
                              ], rows: buildTable(interpretedMessages, MediaQuery.of(context).size.width*0.7)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width*0.7,
                                height: MediaQuery.of(context).size.height*0.05,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(100,100,100,1),
                                    border: Border.all(
                                      color: Color.fromRGBO(255,255,255,0.1),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(2)),
                                ),
                                child: TextFormField(
                                  controller: textCont,
                                  decoration: new InputDecoration(
                                    hintText: 'Send something amazing',
                                    isDense: true,
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(color: Colors.grey)),
                                  ),
                                ),
                              ),
                              Container(
                                //color: Colors.green,
                                height: MediaQuery.of(context).size.height*0.045,
                                 width: MediaQuery.of(context).size.width*0.1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    sendMessage();
                                    updateMessages();
                                    // Navigator.pushNamed(context, '/groups');
                                  },
                                  child: Text('Send', style: TextStyle(fontSize: 12)),
                                ),

                            ),
                          ],
                        ),]
                      )
                  ),
                ]
            ),
          ),
      ),
    );
    // TODO: implement build

    throw UnimplementedError();
  }
}

List<DataRow> buildTable(List<dynamic> transMsg, screenWidth)  {
  List<DataRow> output = [];
    for (int i = 0; i < transMsg.length; i++) {
      try {
        output.add(DataRow(cells: [
          DataCell(
              Row(
                  children:[
                    Container(
                        width: screenWidth*0.8,
                        child: Column(
                                children: [
                                  Text(transMsg[i]["username"],
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
                                  ),
                                  Text("   "+transMsg[i]["sendtime"].seconds.toString(),
                                      style: TextStyle(fontWeight: FontWeight.w100, color: Colors.white54)
                                  ),
                                  Text("   "+transMsg[i]["message"],
                                      style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)
                                  ),
                                ],
                        )
                    ),
                  ]
              )
          ),
          DataCell(Text("", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
        ]));
      } catch(e){
        output.add(DataRow(cells: [
          DataCell(Text("LOADING", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
          DataCell(Text("ERROR", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red))),
        ]));
        print(e);
      }
    }
  return output;
}
















// child: Column(
//     mainAxisAlignment: MainAxisAlignment.end,

// children: [
//   Container(
//     height: MediaQuery.of(context).size.height*0.1,
//     width: MediaQuery.of(context).size.width*0.8,
//     color: Color.fromRGBO(69,69,69,1),
//     child: TextFormField(
//
//       onSaved: (String? value) {
//         // This optional block of code can be used to run
//         // code when the user saves the form.
//       },
//       validator: (String? value) {
//         return (value != null && value.contains('@')) ? 'Do not use the @ char.' : null;
//       },
//       decoration: const InputDecoration(
//         hintText: 'Send something amazing',
//       ),
//     ),
//     ),
// ]
//   ),