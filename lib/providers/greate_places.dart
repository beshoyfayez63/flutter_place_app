import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatePlaces with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places {
    return [..._places];
  }

  Place findById(String id) {
    return _places.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(
      String title, File imageFile, PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
      pickedLocation.latitude,
      pickedLocation.longitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toIso8601String(),
      title: title,
      image: imageFile,
      location: updatedLocation,
    );
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert('user_places', newPlace.toJson());
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _places = dataList
        .map((place) => Place(
              id: place['id'],
              image: File(place['image']),
              title: place['title'],
              location: PlaceLocation(
                latitude: place['loc_lat'],
                longitude: place['loc_lng'],
                address: place['address'],
              ),
            ))
        .toList();
    notifyListeners();
  }
}
