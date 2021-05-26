import 'dart:convert';
import 'package:mclimate/models/tokens.dart';
import 'package:mclimate/pages/home/page.dart';
import 'package:mclimate/pages/menu/page.dart';
import 'package:mclimate/pages/password_change/page.dart';
import 'package:mclimate/repositories/devices.dart';
import 'package:mclimate/repositories/profiles.dart';
import 'package:mclimate/repositories/rooms.dart';
import 'package:mclimate/services/storage.dart' as storage;
import 'package:flutter/material.dart';
import 'dart:io';
import '../../services/account.dart' as account;
import '../../components/error_widget.dart' as error;
import '../activation/page.dart';

class CreateProfileData with ChangeNotifier {
  bool _isBusy = false;
  String _name;
  String _nameError;
  double _temperature;
  String _temperatureError;

  double _humidity;
  String _humidityError;

  void clear() {
    _isBusy = false;
    _name = null;
    _nameError = null;
    _temperature = null;
    _temperatureError = null;

    _humidity = null;
    _humidityError = null;
  }

//Занят
  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

//Email
  set name(String value) {
    _name = value;
    //notifyListeners();
  }

  String get name => _name;

//Ошибка email
  set nameError(String value) {
    _nameError = value;
    notifyListeners();
  }

  String get nameError => _nameError;

  set temperature(double value) {
    _temperature = value;
    //notifyListeners();
  }

  double get temperature => _temperature;

  set temperatureError(String value) {
    _temperatureError = value;
    notifyListeners();
  }

  String get temperatureError => _temperatureError;

  /////////////////////////////////////////////
  set humidity(double value) {
    _humidity = value;
    //notifyListeners();
  }

  double get humidity => _humidity;

  set humidityError(String value) {
    _humidityError = value;
    notifyListeners();
  }

  String get humidityError => _humidityError;

  void create(context) async {
    nameError = null;
    isBusy = true;
    //print("$email,$password");
    final response = await createProfile(name, temperature, humidity);
    if (response == null) {
      isBusy = false;
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return error.ErrorWidget(message: "Нет соединения");
          });
    } else {
      switch (response.statusCode) {
        case HttpStatus.badRequest:
          {
            if (jsonDecode(response.body)["Name"] != null)
              nameError = jsonDecode(response.body)["Name"][0].toString();
            if (jsonDecode(response.body)["TargetTemperature"] != null)
              temperatureError =
                  jsonDecode(response.body)["TargetTemperature"][0].toString();
            if (jsonDecode(response.body)["TargetHumidity"] != null)
              humidityError =
                  jsonDecode(response.body)["TargetHumidity"][0].toString();
            break;
          }
        case HttpStatus.ok:
          {
            Navigator.pop(context);
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
        case HttpStatus.forbidden:
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
}
