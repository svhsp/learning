import 'package:flutter/material.dart';
import 'package:teaching_at_svhsp/common/loading_page_flow.dart';
import 'package:teaching_at_svhsp/pages/loading_page.dart';
import 'package:teaching_at_svhsp/services/location.dart';

class LocationCard extends StatelessWidget {
  final Location location;

  const LocationCard({
    Key? key,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Card(
        child: ListTile(
          onTap: () {
            // if a location is selected, route to loading page which do three
            // things: 1. call world time api asynchronously. 2.show the spinner
            // while waiting for API call to finish. 3. route to home page to
            // show the time & location once api call returns data.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    LoadingPage(pageFlow: LoadingPageFlow.loadSelectedLocation),
                settings: RouteSettings(arguments: {
                  'location': location.name,
                  'flag': location.flag,
                  'url': location.url,
                }),
              ),
            );
          },
          title: Text(location.name),
          leading: CircleAvatar(
            backgroundImage: AssetImage('images/${location.flag}'),
          ),
        ),
      ),
    );
    ;
  }
}
