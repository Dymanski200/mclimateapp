import 'package:flutter/material.dart';

class Device {
  int id;
  int roomID;
  String name;
  String status;

  Device({
    @required this.id,
    @required this.roomID,
    @required this.name,
    @required this.status,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      roomID: json['roomID'],
      name: json['name'],
      status: json['status'],
    );
  }
}
