import 'package:mclimate/pages/home/page.dart';
import 'package:mclimate/pages/rooms/page.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../services/account.dart' as account;
import '../../components/error_widget.dart' as error;

class LoadingData with ChangeNotifier {
  bool _isBusy = false;

  set isBusy(bool value) {
    _isBusy = value;
    notifyListeners();
  }

  bool get isBusy => _isBusy;

  void refresh(context) async {
    isBusy = true;
    final response = await account.refresh();
    if (response == null) {
      isBusy = false;
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return error.ErrorWidget(message: "Нет соединения");
          }).whenComplete(() => refresh(context));
    } else {
      if (response.statusCode == HttpStatus.ok) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RoomsPage()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }
  }
}
