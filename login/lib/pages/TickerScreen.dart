import 'package:flutter/material.dart';
import 'package:login/pages/profileScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TickerScreen extends StatefulWidget {
  const TickerScreen({super.key});

  @override
  TickerScreenState createState() => new TickerScreenState();
}

class TickerScreenState extends State<TickerScreen> {
  @override
  Widget build (BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String spaces = '';
    String smallSpaces = '';
    String spaces3 = '';

    for (int i = 0; i < width / 0.1; i++) {
      spaces3 += ' ';
    }

    for (int i = 0; i < width / 24; i++) {
      spaces += ' ';
    }

    for (int i = 0; i < width / 15; i++) {
      smallSpaces += ' ';
    }

    return Scaffold(appBar: AppBar(title: Row(children: [Text('Stocks' + spaces3, style: TextStyle(color: Colors.black),), IconButton(onPressed: () {

    }, icon: Icon(Icons.search, color: Colors.black,))],), backgroundColor: Colors.white70,), body:SafeArea(child: Column(children: [
      SizedBox(width: 1,  height: 30,),
      Column(
        children: <Widget>[
          SizedBox(width: 1, height: 10),
          DataTable(
        columns: const <DataColumn>[
        DataColumn(
        label: Expanded(
        child: Text(
        'Company Name',
        style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    ),
    DataColumn(
    label: Expanded(
    child: Text(
    'Price',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    ),
    DataColumn(
    label: Expanded(
    child: Text(
    'Percentage',
    style: TextStyle(fontWeight: FontWeight.bold),
    ),
    ),
    ),
    ],
    rows: const <DataRow>[
    DataRow(
    cells: <DataCell>[
    DataCell(Text('UrMom')),
    DataCell(Text('420.69')),
    DataCell(Text('6.9%')),
    ],
    ),
    DataRow(
    cells: <DataCell>[
    DataCell(Text('UrDad')),
    DataCell(Text('420.69')),
    DataCell(Text('4.2%')),
    ],
    ),
    DataRow(
    cells: <DataCell>[
    DataCell(Text('GOOG')),
    DataCell(Text('69.42')),
    DataCell(Text('2.3%')),
    ],
    ),
    ],
    ),
        ],
      )
    ],),
    ),);
  }
}