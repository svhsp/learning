import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: SafeArea(
          child: ExampleApp(),
        ),
      ),
    );
  }
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  TextEditingController controller = TextEditingController();
  final List<Actor> actors = [
    Actor(age: 47, name: 'Leonardo', lastName: 'DiCaprio'),
    Actor(age: 58, name: 'Johnny', lastName: 'Depp'),
    Actor(age: 78, name: 'Robert', lastName: 'De Niro'),
    Actor(age: 44, name: 'Tom', lastName: 'Hardy'),
    Actor(age: 66, name: 'Denzel', lastName: 'Washington'),
    Actor(age: 49, name: 'Ben', lastName: 'Affleck'),
  ];
  String temp = "";
  TextStyle style = TextStyle(fontSize: 25);

  @override
  Widget build(BuildContext context) {
    String input = "";
    bool isEnable = true;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(temp),
          const Text('Searchable list with divider'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SearchableList<Actor>(
                searchFieldEnabled: isEnable,
                style: style,
                // onPaginate: () async {
                //   print("hello");
                //   await Future.delayed(const Duration(milliseconds: 1));
                //   setState(() {
                //     actors.addAll([
                //       Actor(age: 22, name: 'Fathi', lastName: 'Hadawi'),
                //       Actor(age: 22, name: 'Hichem', lastName: 'Rostom'),
                //       Actor(age: 22, name: 'Kamel', lastName: 'Twati'),
                //     ]);
                //   });
                // },
                builder: (Actor actor) => ActorItem(actor: actor),
                loadingWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Loading actors...')
                  ],
                ),
                errorWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text('Error while fetching actors')
                  ],
                ),
                searchTextController: controller,
                asyncListCallback: () async {
                  print("the async list callback: " + controller.text.toString());
                  // final dio = Dio();
                  // final response = await dio.get("https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=" + controller.text.toString() + "&apikey=G4UJ9ECYT8N1K1O6");
                  // Map<String, dynamic> queryResults = response.data;
                  // List<dynamic> results = queryResults['bestMatches'];
                  // List<String> resultStockNames = List.empty(growable: true);
                  return actors;
                },
                asyncListFilter: (q, list) {
                  input = q;
                  setState(() {
                    style =  TextStyle(fontSize: 35);
                    isEnable  = false;
                    temp = "efwewfwef";
                    print("resultOner: " + controller.text.toString());
                    actors.add(Actor(age: 4343, name: "fwefew", lastName: "erwrwe"));
                  });
                  return list
                      .where((element) => element.name.contains(q))
                      .toList();
                },
                emptyWidget: const EmptyView(),
                onRefresh: () async {},
                onItemSelected: (Actor item) {},
                inputDecoration: InputDecoration(
                  labelText: "Search Actor",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                secondaryWidget: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    color: Colors.grey[400],
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      child: Center(
                        child: Icon(Icons.sort),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActorItem extends StatelessWidget {
  final Actor actor;

  const ActorItem({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      print(actor.name);
    },
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.star,
                color: Colors.yellow[700],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Company Name: ${actor.name}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Ticker Name: ${actor.lastName}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    ),
      );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('no actor is found with this name'),
      ],
    );
  }
}

class Actor {
  int age;
  String name;
  String lastName;

  Actor({
    required this.age,
    required this.name,
    required this.lastName,
  });
}