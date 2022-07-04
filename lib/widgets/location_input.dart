import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../screens/map_screen.dart';
import '../helpers/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  const LocationInput(this.onSelectPlace, {Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImgUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      latitude: lat,
      longitude: lng,
    );
    setState(() {
      _previewImgUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    final locationData = await Location().getLocation();

    if (locationData == null) return;
    _showPreview(locationData.latitude!, locationData.longitude!);

    widget.onSelectPlace(locationData.latitude, locationData.longitude);
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapScreen(isSelecting: true),
      ),
    );
    if (selectedLocation == null) return;
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: _previewImgUrl == null
              ? const Text(
                  'No Location Choosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImgUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Current Location'),
              style: TextButton.styleFrom(
                // backgroundColor: Theme.of(context).primaryColor,
                primary: Theme.of(context).primaryColor,
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: const Icon(Icons.map),
              label: const Text('Select on map'),
              style: TextButton.styleFrom(
                // backgroundColor: Theme.of(context).primaryColor,
                primary: Theme.of(context).primaryColor,
              ),
            )
          ],
        )
      ],
    );
  }
}
