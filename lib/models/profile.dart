import 'package:flutter/material.dart';

class Profile {
  int id;
  String name;
  double targetTemperature;
  double targetHumidity;

  Profile({
    @required this.id,
    @required this.name,
    @required this.targetTemperature,
    @required this.targetHumidity,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      name: json['name'],
      targetTemperature: json['targetTemperature'].toDouble(),
      targetHumidity: json['targetHumidity'].toDouble(),
    );
  }
}
