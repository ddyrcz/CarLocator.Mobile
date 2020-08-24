
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/car.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Samochody', home: CarsList());
  }
}

class CarsList extends StatefulWidget {
  @override
  _CarsState createState() => _CarsState();
}

class _CarsState extends State<CarsList> {
  List<Car> _cars = [
    Car(name: "Ford Fusion", registrationNumber: "ABC 123"),
    Car(name: "Audi A3", registrationNumber: "ABC 234"),
    Car(name: "Opel Astra", registrationNumber: "ABC 345"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Samochody'),
      ),
      body: _buildCarsList(),
    );
  }

  Widget _buildCarsList() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _cars.length,
        itemBuilder: (context, index) {
          return _buildCarRow(_cars[index], index);
        });
  }

  Widget _buildCarRow(Car car, int index) {
   return  Card(
     child: ListTile(
       title: Text(car.name),
       subtitle: Text(car.registrationNumber),
       leading: Icon(Icons.directions_car),
       onTap: _carTapped,
     ),
   );
  }

  void _carTapped(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CarLocation()),
    );
  }
}

class CarLocation extends StatefulWidget {
  @override
  _CarLocationState createState() => _CarLocationState();
}

class _CarLocationState extends State<CarLocation> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokalizacja GPS'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );

  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

