import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarLocation extends StatefulWidget {

  final String id;

  CarLocation({this.id});

  @override
  _CarLocationState createState() => _CarLocationState(id: id);
}

class _CarLocationState extends State<CarLocation> {

  final String id;

  _CarLocationState({this.id});

  double initLat = 50.595402;
  double initLng = 18.967740;

  GoogleMapController _controller;
  Marker _marker;

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(50.595402, 18.967740),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    const oneSec = const Duration(seconds:1);
    Timer.periodic(oneSec, (Timer t)  =>  updateCarLocation());
  }

  void updateCarLocation() async{
    var response = await http.get("https://vehiclelocatorapi.azurewebsites.net/api/vehicles/" + this.id);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var map = jsonDecode(response.body);

    initLat = map["mostRecentLocation"]["lat"];
    initLng = map["mostRecentLocation"]["lon"];

    print(initLat);
    print(initLng);


    setState(() {
      _marker = Marker(
        markerId: MarkerId("0"),
        //icon: _marketIcon,
        position: LatLng(initLat, initLng),
      );

      _controller.animateCamera(CameraUpdate.newLatLng(LatLng(initLat, initLng)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokalizacja GPS'),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: Set.of((_marker != null) ? [_marker] : []),
      ),
    );
  }
}
