import 'dart:convert';
import 'dart:io';
import 'package:mclimate/models/change.dart';
import 'package:mclimate/models/room.dart';
import 'package:mclimate/repositories/changes.dart';
import 'package:mclimate/repositories/devices.dart';

import '../../components/error_widget.dart' as error;
import '../../repositories/devices.dart' as repository;
import '../../repositories/rooms.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mclimate/models/device.dart';
import 'package:mclimate/pages/home/page.dart';

class DevicesData with ChangeNotifier {
  List<Device> _devices = [];
  bool _isBusy = false;
  bool _isNotFound = false;

  set devices(List<Device> value) {
    _devices = value;
    notifyListeners();
  }

  List<Device> get devices => _devices;

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

  void delete(context, int roomID, int id) async {
    isNotFound = false;
    devices = [];
    isBusy = true;
    http.Response response;
    response = await deleteDevice(id);
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
      refresh(context, roomID);
    }
  }

  void refresh(context, int roomID) async {
    isNotFound = false;
    devices = [];
    isBusy = true;
    http.Response response;
    response = await repository.getDevices(roomID);
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
            devices = temp.map<Device>((json) {
              return Device.fromJson(json);
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

class RoomData with ChangeNotifier {
  bool _isBusy = false;

  Room _room;

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

  set room(Room value) {
    _room = value;
    notifyListeners();
  }

  Room get room => _room;

  void refresh(context, int id) async {
    room = null;
    isBusy = true;
    http.Response response;
    response = await getRoom(id);
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
            room = Room.fromJson(jsonDecode(response.body));
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
      }
      isBusy = false;
    }
  }
}

class ChangesData with ChangeNotifier {
  bool _isBusy = false;
  bool _isNotFound = false;

  List<Change> _changes;

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

  set changes(List<Change> value) {
    _changes = value;
    notifyListeners();
  }

  set isNotFound(bool value) {
    _isNotFound = value;
    notifyListeners();
  }

  bool get isNotFound => _isNotFound;

  List<Change> get changes => _changes;

  void refresh(context, int roomID) async {
    changes = [];
    isBusy = true;
    isNotFound = false;
    http.Response response;
    response = await getChanges(roomID);
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
            changes = temp.map<Change>((json) {
              return Change.fromJson(json);
            }).toList();
            break;
          }

        case (HttpStatus.notFound):
          {
            isNotFound = true;
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
      }
      isBusy = false;
    }
  }
}
