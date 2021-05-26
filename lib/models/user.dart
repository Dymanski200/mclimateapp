import 'package:flutter/material.dart';

class User {
  int id;
  String surname;
  String name;
  String patronymic;
  String role;
  DateTime registrationDate;

  User({
    @required this.id,
    @required this.name,
    @required this.surname,
    @required this.patronymic,
    @required this.role,
    @required this.registrationDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      patronymic: json['patronymic'],
      role: json['role'],
      registrationDate: DateTime.parse(json['registrationDate']),
    );
  }
}
