import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mclimate/models/rule.dart';
import 'package:mclimate/pages/home/page.dart';
import 'package:mclimate/repositories/profiles.dart';
import 'package:mclimate/repositories/rules.dart';
import '../../components/error_widget.dart' as error;

class RulesData with ChangeNotifier {
  List<Rule> _rules = [];
  bool _isBusy = false;
  bool _isNotFound = false;
  BuildContext currentContext;

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

  set rules(List<Rule> value) {
    _rules = value;
    notifyListeners();
  }

  List<Rule> get rules => _rules;

  void refresh(context, int deviceID) async {
    isNotFound = false;
    rules = [];
    isBusy = true;
    http.Response response;
    response = await getRules(deviceID);
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
            rules = temp.map<Rule>((json) {
              return Rule.fromJson(json);
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

  void delete(int deviceID, int id) async {
    isNotFound = false;
    rules = [];
    isBusy = true;
    http.Response response;
    response = await deleteRule(id);
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
        case (HttpStatus.notFound):
          {
            isNotFound = true;
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
      refresh(currentContext, deviceID);
    }
  }
}
