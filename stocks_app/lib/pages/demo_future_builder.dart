// import 'package:flutter/material.dart';
// import '../Widgets/stockclass.dart';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// class futureBuilder extends StatefulWidget {
//   const futureBuilder({required this.title});
//   final String title;
//
//   @override
//   State<futureBuilder> createState() => _futureBuilderState();
// }
//
// class _futureBuilderState extends State<futureBuilder> {
//   List<String> stockIds = ["APPL", "GAMESTOP", "SVB"];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             DataTable(columns: const [
//               DataColumn(label: Text("Symbol")),
//               DataColumn(label: Text("Price")),
//               DataColumn(label: Text("Change")),
//             ], rows: buildTable(stockList))
//           ],
//         ),
//       ),
//     );
//   }
// }

