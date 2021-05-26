import 'dart:convert';
import 'package:mclimate/models/tokens.dart';
import 'package:mclimate/pages/menu/page.dart';
import 'package:mclimate/pages/password_change/page.dart';
import 'package:mclimate/pages/rooms/page.dart';
import 'package:mclimate/services/storage.dart' as storage;
import 'package:flutter/material.dart';
import 'dart:io';
import '../../services/account.dart' as account;
import '../../components/error_widget.dart' as error;
import '../activation/page.dart';

class LoginData with ChangeNotifier {
  bool _isBusy = false;
  bool _isGetCodeBusy = false;
  String _email;
  String _emailError;
  String _password;
  String _passwordError;

  void clear() {
    _isBusy = false;
    _isGetCodeBusy = false;
    _email = null;
    _emailError = null;
    _password = null;
    _passwordError = null;
  }

//Занят
  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

  set isGetCodeBusy(bool value) {
    _isGetCodeBusy = value;
    notifyListeners();
  }

  bool get isGetCodeBusy => _isGetCodeBusy;

//Email
  set email(String value) {
    _email = value;
    //notifyListeners();
  }

  String get email => _email;

//Ошибка email
  set emailError(String value) {
    _emailError = value;
    notifyListeners();
  }

  String get emailError => _emailError;

//Пароль
  set password(String value) {
    _password = value;
    //notifyListeners();
  }

  String get password => _password;

//Ошибка пароля
  set passwordError(String value) {
    _passwordError = value;
    notifyListeners();
  }

  String get passwordError => _passwordError;

  void login(context) async {
    emailError = null;
    passwordError = null;
    isBusy = true;
    //print("$email,$password");
    final response = await account.login(email, password);
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
            if (jsonDecode(response.body)["Email"] != null)
              emailError = jsonDecode(response.body)["Email"][0].toString();
            if (jsonDecode(response.body)["Password"] != null)
              passwordError =
                  jsonDecode(response.body)["Password"][0].toString();
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
        case HttpStatus.forbidden:
          {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ActivationPage(email)));
            break;
          }
      }
      isBusy = false;
    }
  }

  void getCode(context) async {
    emailError = null;
    passwordError = null;
    isGetCodeBusy = true;

    final response = await account.getCode(email);
    if (response == null) {
      isGetCodeBusy = false;
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return error.ErrorWidget(message: "Нет соединения");
          });
    } else {
      switch (response.statusCode) {
        case HttpStatus.badRequest:
          {
            if (jsonDecode(response.body)["Email"] != null)
              emailError = jsonDecode(response.body)["Email"][0].toString();
            break;
          }
        case HttpStatus.ok:
          {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PasswordChangePage(email)));
            break;
          }
        case HttpStatus.internalServerError:
          {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return error.ErrorWidget(message: "Ошибка сервера");
                });
            break;
          }
      }
      isGetCodeBusy = false;
    }
  }
}

class RegistrationData with ChangeNotifier {
  bool _isBusy = false;

  String _email;
  String _emailError;

  String _password;
  String _passwordError;

  String _confirmPassword;
  String _confirmPasswordError;

  String _surname;
  String _surnameError;

  String _name;
  String _nameError;

  String _patronymic;
  String _patronymicError;

  void clear() {
    _isBusy = false;

    _email = null;
    _emailError = null;

    _password = null;
    _passwordError = null;

    _confirmPassword = null;
    _confirmPasswordError = null;

    _surname = null;
    _surnameError = null;

    _name = null;
    _nameError = null;

    _patronymic = null;
    _patronymicError = null;
  }

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

  set email(String value) {
    _email = value;
  }

  String get email => _email;

  set emailError(String value) {
    _emailError = value;
    notifyListeners();
  }

  String get emailError => _emailError;

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

  set surname(String value) {
    _surname = value;
  }

  String get surname => _surname;

  set surnameError(String value) {
    _surnameError = value;
    notifyListeners();
  }

  String get surnameError => _surnameError;

  set name(String value) {
    _name = value;
  }

  String get name => _name;

  set nameError(String value) {
    _nameError = value;
    notifyListeners();
  }

  String get nameError => _nameError;

  set patronymic(String value) {
    _patronymic = value;
  }

  String get patronymic => _patronymic;

  set patronymicError(String value) {
    _patronymicError = value;
    notifyListeners();
  }

  String get patronymicError => _patronymicError;

  void registration(context) async {
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;
    surnameError = null;
    nameError = null;
    patronymicError = null;

    isBusy = true;
    final response = await account.registration(
        email, password, confirmPassword, surname, name, patronymic);
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
            if (jsonDecode(response.body)["Email"] != null)
              emailError = jsonDecode(response.body)["Email"][0].toString();

            if (jsonDecode(response.body)["Password"] != null)
              passwordError =
                  jsonDecode(response.body)["Password"][0].toString();

            if (jsonDecode(response.body)["ConfirmPassword"] != null)
              confirmPasswordError =
                  jsonDecode(response.body)["ConfirmPassword"][0].toString();

            if (jsonDecode(response.body)["Surname"] != null)
              surnameError = jsonDecode(response.body)["Surname"][0].toString();

            if (jsonDecode(response.body)["Name"] != null)
              nameError = jsonDecode(response.body)["Name"][0].toString();

            if (jsonDecode(response.body)["Patronymic"] != null)
              patronymicError =
                  jsonDecode(response.body)["Patronymic"][0].toString();
            break;
          }
        case HttpStatus.ok:
          {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ActivationPage(email)));
            break;
          }
        case HttpStatus.internalServerError:
          {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return error.ErrorWidget(message: "Ошибка сервера");
                });
            break;
          }
      }
      isBusy = false;
    }
  }
}
