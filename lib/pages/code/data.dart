import 'dart:convert';
import 'dart:io';
import 'package:mclimate/models/profile.dart';
import 'package:http/http.dart' as http;
import 'package:mclimate/pages/home/page.dart';
import 'package:mclimate/repositories/rooms.dart';
import '../../components/error_widget.dart' as error;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CodeData with ChangeNotifier {
  bool _isBusy = false;
  String _code;
  String _codeError;

  void clear() {
    _isBusy = false;
    _code = null;
    _codeError = null;
  }

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

  set code(String value) {
    _code = value;
  }

  String get code => _code;

//Ошибка email
  set codeError(String value) {
    _codeError = value;
    notifyListeners();
  }

  String get codeError => _codeError;

  void setClimate(context, int roomID, Profile profile) async {
    isBusy = true;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('room_$roomID', code ?? "");

    http.Response response;
    response = await setTargets(
        roomID, profile.targetTemperature, profile.targetHumidity);
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
            codeError = null;
            code = null;
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
        case (HttpStatus.badRequest):
          {
            if (jsonDecode(response.body)["Code"] != null)
              codeError = jsonDecode(response.body)["Code"][0].toString();
            break;
          }
      }
      isBusy = false;
    }
  }
}
