import 'package:bosnia/pages/search_delegate_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BayAreaSearch extends StatefulWidget {

  const BayAreaSearch({Key? key}) : super(key: key);

  @override
  State<BayAreaSearch> createState() =>
      _BayAreaSearchState();
}

class _BayAreaSearchState extends State<BayAreaSearch> {
  String selectedCity = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bay Area City Search',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          OutlinedButton.icon(
            label: Text('Search'),
            icon: Icon(Icons.search),
            style: OutlinedButton.styleFrom(
                primary: Colors.deepOrange,
                side: BorderSide(color: Colors.blue)
            ),
            onPressed: () async {
              final res = await showSearch(
                  context: context,
                  delegate: SearchLocations(
                      locations: locations, suggestedLocations: suggestedLocations
                  )
              );
              setState(() {
                selectedCity = res;
              });
            },
          ),
          selectedCity == '' ? Container() :
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                color: Colors.deepOrange,
                child: Text(
                  selectedCity,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
              ),
          Expanded(
              child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, idx) {
                  return ListTile(
                    title: Text(locations[idx])
                  );
                },
              ))
        ],
      ),
    );
  }
}


final List<String> locations = [
  "Alameda",
  "Albany",
  "American Canyon",
  "Antioch",
  "Atherton",
  "Belmont",
  "Belvedere",
  "Benicia",
  "Berkeley",
  "Brisbane",
  "Burlingame",
  "Campbell",
  "Clayton",
  "Colma",
  "Concord",
  "Corte Madera",
  "Cupertino",
  "Daly City",
  "Danville",
  "Dublin",
  "East Palo Alto",
  "El Cerrito",
  "Emeryville",
  "Fairfax",
  "Foster City",
  "Fremont",
  "Gilroy",
  "Half Moon Bay",
  "Hayward",
  "Healdsburg",
  "Hercules",
  "Hillsborough",
  "Lafayette",
  "Larkspur",
  "Livermore",
  "Los Altos",
  "Los Altos Hills",
  "Los Gatos",
  "Martinez",
  "Menlo Park",
  "Mill Valley",
  "Millbrae",
  "Milpitas",
  "Moraga",
  "Morgan Hill",
  "Mountain View",
  "Newark",
  "Novato",
  "Oakland",
  "Oakley",
  "Orinda",
  "Pacifica",
  "Palo Alto",
  "Petaluma",
  "Piedmont",
  "Pinole",
  "Pittsburg",
  "Pleasanton",
  "Pleasant Hill",
  "Port Costa",
  "Redwood City",
  "Richmond",
  "Rohnert Park",
  "Ross",
  "Helena",
  "San Anselmo",
  "San Bruno",
  "San Carlos",
  "San Francisco",
  "San Jose",
  "San Leandro",
  "San Mateo",
  "San Pablo",
  "San Rafael",
  "San Ramon",
  "Santa Clara",
  "Santa Rosa",
  "Saratoga",
  "Sausalito",
  "Sebastopol",
  "Sonoma",
  "South San Francisco",
  "Suisun City",
  "Sunnyvale",
  "Tiburon",
  "Union City",
  "Vallejo",
  "Walnut Creek",
  "Windsor",
  "Woodside"
];


final List<String> suggestedLocations = [
  "Almaden",
  "Fremont",
  "Los Gatos",
  "Mountain View",
  "Morgan Hill",
  "Palo Alto",
  "San Francisco",
  "San Jose",
  "Sunnyvale",
];