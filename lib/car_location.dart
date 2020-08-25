import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarLocation extends StatefulWidget {
  @override
  _CarLocationState createState() => _CarLocationState();
}

class _CarLocationState extends State<CarLocation> {
  Set<Marker> _markers = Set<Marker>();

  double initLoc = 50.595402;

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(50.595402, 18.967740),
    zoom: 14.4746,
  );

  BitmapDescriptor _marketIcon;

  Marker _marker;

  @override
  void initState() {
    super.initState();
    _seMarkerIcon();


  }

  void _seMarkerIcon() async {
    _marketIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/car_icon.png");
  }

  void _updateCarLocation() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokalizacja GPS'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _initialPosition,
        onTap: (lanlng) {

          initLoc =  initLoc + 0.0005;

          setState(() {



            _marker = Marker(
              markerId: MarkerId("0"),
              icon: _marketIcon,
              position: LatLng(initLoc, 18.967740),
            );
          });
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.of((_marker != null) ? [_marker] : []),
      ),
    );
  }
}