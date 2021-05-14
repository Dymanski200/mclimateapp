import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mclimate/pages/home/page.dart';
import 'package:mclimate/repositories/rooms.dart' as repository;
import '../../models/room.dart';
import 'dart:io';
import '../../components/error_widget.dart' as error;

class MyRoomsData extends RoomsData {
  @override
  void refresh(context) async {
    isNotFound = false;
    rooms = [];
    isBusy = true;
    http.Response response;

    response = await repository.getMyRooms();
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
            rooms = temp.map<Room>((json) {
              return Room.fromJson(json);
            }).toList();
            break;
          }
        case (HttpStatus.unauthorized):
          {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
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

class RoomsData with ChangeNotifier {
  List<Room> _rooms = [];
  bool _isBusy = false;
  bool _isNotFound = false;

  set rooms(List<Room> value) {
    _rooms = value;
    notifyListeners();
  }

  List<Room> get rooms => _rooms;

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

  void refresh(context) async {
    isNotFound = false;
    rooms = [];
    isBusy = true;
    http.Response response;
    response = await repository.getRooms();
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
            rooms = temp.map<Room>((json) {
              return Room.fromJson(json);
            }).toList();
            break;
          }
        case (HttpStatus.unauthorized):
          {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
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