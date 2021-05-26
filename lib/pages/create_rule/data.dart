import 'dart:convert';
import 'package:mclimate/pages/home/page.dart';
import 'package:mclimate/repositories/rules.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../components/error_widget.dart' as error;

class CreateRuleData with ChangeNotifier {
  bool _isBusy = false;
  bool _temperature = true;
  String _temperatureError;

  double _offset = 0;
  String _offsetError;

  String _command;
  String _commandError;

  String _status;
  String _statusError;

  void clear() {
    _isBusy = false;
    _temperature = true;
    _temperatureError = null;

    _offset = 0;
    _offsetError = null;

    _command = null;
    _commandError = null;

    _status = null;
    _statusError = null;
  }

//Занят
  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

//Email
  set temperature(bool value) {
    _temperature = value;
    notifyListeners();
  }

  bool get temperature => _temperature;

//Ошибка email
  set temperatureError(String value) {
    _temperatureError = value;
    notifyListeners();
  }

  String get temperatureError => _temperatureError;

  set offset(double value) {
    _offset = value;
  }

  double get offset => _offset;

  set offsetError(String value) {
    _offsetError = value;
    notifyListeners();
  }

  String get offsetError => _offsetError;

  set command(String value) {
    _command = value;
  }

  String get command => _command;

  set commandError(String value) {
    _commandError = value;
    notifyListeners();
  }

  String get commandError => _commandError;

  set status(String value) {
    _status = value;
  }

  String get status => _status;

  set statusError(String value) {
    _statusError = value;
    notifyListeners();
  }

  String get statusError => _statusError;

  void create(context, int deviceID) async {
    temperatureError = null;
    offsetError = null;
    commandError = null;
    statusError = null;

    isBusy = true;

    final response =
        await createRule(deviceID, temperature, offset ?? 0, command, status);
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
            print(jsonDecode(response.body));
            if (jsonDecode(response.body)["Temperature"] != null)
              temperatureError =
                  jsonDecode(response.body)["Temperature"][0].toString();

            if (jsonDecode(response.body)["Offset"] != null)
              offsetError = jsonDecode(response.body)["Offset"][0].toString();

            if (jsonDecode(response.body)["Command"] != null)
              commandError = jsonDecode(response.body)["Command"][0].toString();

            if (jsonDecode(response.body)["Status"] != null)
              statusError = jsonDecode(response.body)["Status"][0].toString();
            break;
          }
        case HttpStatus.ok:
          {
            temperature = true;
            offset = 0;
            command = null;
            status = null;
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
