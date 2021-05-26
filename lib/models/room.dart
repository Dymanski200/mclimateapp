import 'package:flutter/cupertino.dart';

class Room {
  int id;
  String name;
  double temperature;
  double humidity;
  double targetTemperature;
  double targetHumidity;
  DateTime previousUpdate;

  Room({
    @required this.id,
    @required this.name,
    @required this.temperature,
    @required this.humidity,
    @required this.targetTemperature,
    @required this.targetHumidity,
    @required this.previousUpdate,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      name: json['name'],
      temperature: json['temperature'].toDouble(),
      humidity: json['humidity'].toDouble(),
      targetTemperature: json['targetTemperature'].toDouble(),
      targetHumidity: json['targetHumidity'].toDouble(),
      previousUpdate: DateTime.parse(json['previousUpdate']),
    );
  }
}
