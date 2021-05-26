import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mclimate/models/profile.dart';
import 'package:http/http.dart' as http;
import 'package:mclimate/pages/code/page.dart';
import 'package:mclimate/pages/home/page.dart';
import 'package:mclimate/repositories/profiles.dart';
import 'package:mclimate/repositories/rooms.dart';
import '../../components/error_widget.dart' as error;

class ProfilesData with ChangeNotifier {
  BuildContext currentContext;
  int currentRoomID;
  List<Profile> _profiles = [];
  bool _isBusy = false;
  bool _isNotFound = false;

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

  set profiles(List<Profile> value) {
    _profiles = value;
    notifyListeners();
  }

  List<Profile> get profiles => _profiles;

  void refresh(context) async {
    isNotFound = false;
    profiles = [];
    isBusy = true;
    http.Response response;
    response = await getProfiles();
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
            profiles = temp.map<Profile>((json) {
              return Profile.fromJson(json);
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
    }
  }

  void delete(int id) async {
    isNotFound = false;
    profiles = [];
    isBusy = true;
    http.Response response;
    response = await deleteProfile(id);
    if (response == null) {
      isBusy = false;
      showModalBottomSheet<void>(
          context: currentContext,
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
              currentContext,
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
            break;
          }
        case (HttpStatus.forbidden):
          {
            showModalBottomSheet<void>(
                context: currentContext,
                builder: (BuildContext context) {
                  return error.ErrorWidget(message: "Нет доступа");
                });
            break;
          }
      }
      isBusy = false;
      refresh(currentContext);
    }
  }

  void setClimate(Profile profile) async {
    isNotFound = false;
    profiles = [];
    isBusy = true;
    http.Response response;
    response = await setTargets(
        currentRoomID, profile.targetTemperature, profile.targetHumidity);
    if (response == null) {
      isBusy = false;
      showModalBottomSheet<void>(
          context: currentContext,
          builder: (BuildContext context) {
            return error.ErrorWidget(message: "Нет соединения");
          });
    } else {
      switch (response.statusCode) {
        case (HttpStatus.ok):
          {
            Navigator.pop(currentContext);
            break;
          }
        case (HttpStatus.unauthorized):
          {
            Navigator.pushAndRemoveUntil(
              currentContext,
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,
            );
            break;
          }
        case (HttpStatus.badRequest):
          {
            if (jsonDecode(response.body)["Code"] != null)
              Navigator.push(
                currentContext,
                MaterialPageRoute(
                    builder: (context) => CodePage(currentRoomID, profile)),
              ).then((value) => Navigator.pop(currentContext));
            break;
          }
      }
      isBusy = false;
    }
  }
}
