import 'package:flutter/material.dart';

class Rule {
  int id;
  int deviceID;
  bool temperature;
  double offset;
  String command;
  String status;

  Rule({
    @required this.id,
    @required this.deviceID,
    @required this.temperature,
    @required this.offset,
    @required this.command,
    @required this.status,
  });

  factory Rule.fromJson(Map<String, dynamic> json) {
    return Rule(
      id: json['id'],
      deviceID: json['deviceID'],
      temperature: json['temperature'],
      offset: json['offset'].toDouble(),
      command: json['command'],
      status: json['status'],
    );
  }
}
