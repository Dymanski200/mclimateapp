import 'dart:convert';
import 'package:mclimate/models/tokens.dart';
import 'package:mclimate/pages/menu/page.dart';
import 'package:mclimate/pages/rooms/page.dart';
import 'package:mclimate/services/storage.dart' as storage;
import 'package:flutter/material.dart';
import 'dart:io';
import '../../services/account.dart' as account;
import '../../components/error_widget.dart' as error;

class PasswordChangeData with ChangeNotifier {
  bool _isBusy = false;

  String _code;
  String _codeError;

  String _password;
  String _passwordError;

  String _confirmPassword;
  String _confirmPasswordError;

  void clear() {
    void clear() {
      _isBusy = false;

      _code = null;
      _codeError = null;

      _password = null;
      _passwordError = null;

      _confirmPassword = null;
      _confirmPasswordError = null;
    }
  }

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

  set password(String value) {
    _password = value;
  }

  String get password => _password;

  set passwordError(String value) {
    _passwordError = value;
    notifyListeners();
  }

  String get passwordError => _passwordError;

  set confirmPassword(String value) {
    _confirmPassword = value;
  }

  String get confirmPassword => _confirmPassword;

  set confirmPasswordError(String value) {
    _confirmPasswordError = value;
    notifyListeners();
  }

  String get confirmPasswordError => _confirmPasswordError;

  void changePassword(context, String email) async {
    codeError = null;
    passwordError = null;
    confirmPasswordError = null;
    isBusy = true;

    final response =
        await account.changePassword(email, code, password, confirmPassword);
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

            if (jsonDecode(response.body)["Password"] != null)
              passwordError =
                  jsonDecode(response.body)["Password"][0].toString();

            if (jsonDecode(response.body)["ConfirmPassword"] != null)
              confirmPasswordError =
                  jsonDecode(response.body)["ConfirmPassword"][0].toString();

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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MenuPage()),
              (Route<dynamic> route) => false,
            );
            break;
          }
      }
      isBusy = false;
    }
  }
}
