
import 'package:flutter/material.dart';

import 'california_search.dart';

class CaliforniaHome extends StatefulWidget {
  const CaliforniaHome({Key? key}) : super(key: key);

  @override
  State<CaliforniaHome> createState() => _CaliforniaHomeState();
}

class _CaliforniaHomeState extends State<CaliforniaHome> {
  String selectedPlace = '';
  List<String> californiaCities = ['San Francisco', 'San Rafael', 'San Jose', 'Palo Alto',
    'Fresno', 'Los Angeles', 'San Diego', 'Santa Barbara', 'Oakland', 'Long Beach',
    'Sacramento', 'San Luis Obispo', 'Berkeley', 'Monterey'];
  List<String> popularCaliforniaCities = ['San Francisco', 'San Jose',
     'Los Angeles', 'San Diego',
    'Sacramento', ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Delegate Class'),
        centerTitle: true,
      ),
      body:
        Center(
          child: Column(
          children: [
            ElevatedButton.icon(
                onPressed: () async {
                  final finalResult = (await showSearch(
                      context: context,
                      delegate: CaliforniaSearch(californiaCities: californiaCities,
                          suggestedCaliforniaCities: popularCaliforniaCities)
                  )
                  );
                  setState(() {
                    selectedPlace = finalResult!;
                  });
                  },
                icon: const Icon(Icons.search), label: const Text('Search')),
            selectedPlace == ''
                ? Container()
                : Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  selectedPlace,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ),
            Expanded(
              child: ListView.builder(
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                itemCount: californiaCities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(californiaCities[index]),
                  );
                },
              ),
            ),

          ],
    ),
        )
    );
  }
}


