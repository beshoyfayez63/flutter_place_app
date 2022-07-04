import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/add_place_screen.dart';
import '../screens/place_detail_screen.dart';
import '../providers/greate_places.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Consumer<GreatePlaces>(
              child: const Center(
                child: Text('No Places Yet'),
              ),
              builder: (context, greatePlaces, child) =>
                  greatePlaces.places.isEmpty
                      ? child!
                      : ListView.builder(
                          itemBuilder: (context, i) => ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  FileImage(greatePlaces.places[i].image),
                            ),
                            title: Text(greatePlaces.places[i].title),
                            subtitle: Text(
                              greatePlaces.places[i].location!.address!,
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: greatePlaces.places[i].id);
                            },
                          ),
                          itemCount: greatePlaces.places.length,
                        ),
            );
          }
        }),
        future: Provider.of<GreatePlaces>(context, listen: false)
            .fetchAndSetPlaces(),
      ),
    );
  }
}
