class Car{
  String id;
  String name;

  Car(this.id, this.name);

  factory Car.fromJson(dynamic json) {
    return Car(json['id'] as String, json['name'] as String);
  }
}