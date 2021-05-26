import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mclimate/models/user.dart';
import 'package:mclimate/pages/home/page.dart';
import 'package:mclimate/repositories/rooms.dart' as repository;
import 'package:mclimate/repositories/users.dart';
import '../../models/room.dart';
import 'dart:io';
import '../../components/error_widget.dart' as error;

class UsersData with ChangeNotifier {
  List<User> _users = [];
  bool _isBusy = false;
  bool _isNotFound = false;

  set users(List<User> value) {
    _users = value;
    notifyListeners();
  }

  List<User> get users => _users;

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

  set isNotFound(bool value) {
    _isNotFound = value;
    notifyListeners();
  }

  bool get isNotFound => _isNotFound;

  void delete(context, int id) async {
    isNotFound = false;
    users = [];
    isBusy = true;
    http.Response response;
    response = await deleteUser(id);
    if (response == null) {
      isBusy = false;
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return error.ErrorWidget(message: "Нет соединения");
          });
    } else {
      switch (response.statusCode) {
        case (HttpStatus.ok):
          {
            break;
          }
        case (HttpStatus.unauthorized):
          {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
            break;
          }
        case (HttpStatus.forbidden):
          {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return error.ErrorWidget(message: "Нет доступа");
                });
            break;
          }
      }
      isBusy = false;
      refresh(context);
    }
  }

  void refresh(context) async {
    isNotFound = false;
    users = [];
    isBusy = true;
    http.Response response;
    response = await getUsers();
    if (response == null) {
      isBusy = false;
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return error.ErrorWidget(message: "Нет соединения");
          });
    } else {
      switch (response.statusCode) {
        case (HttpStatus.ok):
          {
            List temp = jsonDecode(response.body);
            users = temp.map<User>((json) {
              return User.fromJson(json);
            }).toList();
            break;
          }
        case (HttpStatus.unauthorized):
          {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
            break;
          }
        case (HttpStatus.notFound):
          {
            isNotFound = true;
            break;
          }
      }
      isBusy = false;
    }
  }
}
