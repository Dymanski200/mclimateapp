import 'package:flutter/material.dart';

class Change {
  int id;
  String message;
  DateTime date;

  Change({
    @required this.id,
    @required this.message,
    @required this.date,
  });

  factory Change.fromJson(Map<String, dynamic> json) {
    return Change(
      id: json['id'],
      message: json['message'],
      date: DateTime.parse(json['date']),
    );
  }
}
