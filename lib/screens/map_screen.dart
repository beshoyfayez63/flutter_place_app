import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map';
  final PlaceLocation initialLocation;
  final bool isSelecting;
  const MapScreen({
    this.initialLocation =
        const PlaceLocation(latitude: 37.4216863, longitude: -122.0842771),
    this.isSelecting = false,
    Key? key,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                if (_pickedLocation == null) {
                  showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                            content: const Text('Please select a location'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'))
                            ],
                          ));
                  return;
                }
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(Icons.check),
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        onTap: widget.isSelecting ? _selectLocation : null,
        markers: (_pickedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('m1'),
                  position: _pickedLocation ??
                      LatLng(
                        widget.initialLocation.latitude,
                        widget.initialLocation.longitude,
                      ),
                )
              },
      ),
    );
  }
}
