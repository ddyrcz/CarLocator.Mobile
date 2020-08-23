
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/car.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lokalizacja GPS'),
      ),
      body: Container(),
    );
  }
}

