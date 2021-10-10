import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsExample extends StatefulWidget {
  const GoogleMapsExample({Key? key}) : super(key: key);

  @override
  State<GoogleMapsExample> createState() => _GoogleMapsExampleState();
}

class _GoogleMapsExampleState extends State<GoogleMapsExample> {
  GoogleMapController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Google Maps'),
        leading: IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            const CameraPosition cameraPosition = CameraPosition(
              target: LatLng(51.515547, 18.942514),
              zoom: 10.0,
            );
            _controller?.animateCamera(
              CameraUpdate.newCameraPosition(cameraPosition),
            );
          },
        ),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          _controller = controller;
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 10.0,
        ),
      ),
    );
  }
}
