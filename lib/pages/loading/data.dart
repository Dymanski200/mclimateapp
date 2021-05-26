import 'package:mclimate/pages/home/page.dart';
import 'package:mclimate/pages/menu/page.dart';
import 'package:mclimate/pages/rooms/page.dart';
import 'package:flutter/material.dart';
import 'package:mclimate/pages/url/page.dart';
import 'package:mclimate/services/storage.dart';
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
              })
          .whenComplete(() => Navigator.push(
              context, MaterialPageRoute(builder: (context) => UrlPage())))
          .then((value) => refresh(context));
    } else {
      if (response.statusCode == HttpStatus.ok) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MenuPage()),
          (Route<dynamic> route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
        );
      }
    }
  }
}
