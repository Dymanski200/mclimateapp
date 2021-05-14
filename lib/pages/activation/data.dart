import 'dart:convert';
import 'package:mclimate/models/tokens.dart';
import 'package:mclimate/pages/rooms/page.dart';
import 'package:mclimate/services/storage.dart' as storage;
import 'package:flutter/material.dart';
import 'dart:io';
import '../../services/account.dart' as account;
import '../../components/error_widget.dart' as error;

class ActivationData with ChangeNotifier {
  bool _isBusy = false;
  String _code;
  String _codeError;

//Занят
  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

//Email
  set code(String value) {
    _code = value;
  }

  String get code => _code;

  set codeError(String value) {
    _codeError = value;
    notifyListeners();
  }

  String get codeError => _codeError;

  void activation(context, String email) async {
    codeError = null;
    isBusy = true;

    final response = await account.activation(email, code);
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
            if (jsonDecode(response.body)["Code"] != null)
              codeError = jsonDecode(response.body)["Code"][0].toString();

            if (jsonDecode(response.body)["Email"] != null) {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return error.ErrorWidget(
                        message:
                            jsonDecode(response.body)["Email"][0].toString());
                  });
            }
            break;
          }
        case HttpStatus.ok:
          {
            storage.setTokens(Tokens.fromJson(jsonDecode(response.body)));
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => RoomsPage()));
            break;
          }
      }
      isBusy = false;
    }
  }
}
