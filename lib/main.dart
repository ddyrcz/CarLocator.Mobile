import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/car.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';

import 'car_location.dart';

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

  ];


  @override
  void initState() {

    getCars();
    // TODO: implement initState
    super.initState();
  }

  void getCars()async {
    var response =  await http.get("https://vehiclelocatorapi.azurewebsites.net/api/vehicles");

    var vehiclesJson = jsonDecode(response.body);
    List<Car> vehicles = vehiclesJson.map<Car>((tagJson) => Car.fromJson(tagJson)).toList();

    setState(() {
      _cars = vehicles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pojazdy'),
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
    return Card(
      child: ListTile(
        title: Text(car.id),
        subtitle: Text(car.name),
        leading: Icon(Icons.directions_car),
        onTap: _carTapped,
      ),
    );
  }

  void _carTapped() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CarLocation()),
    );
  }
}


