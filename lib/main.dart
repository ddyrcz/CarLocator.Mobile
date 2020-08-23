
import 'package:flutter/material.dart';
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
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${car.name}",
            style: TextStyle(fontSize: 24.0,
            fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            "${car.registrationNumber}",
          ),
        ],
      ),
    ));
  }
}
