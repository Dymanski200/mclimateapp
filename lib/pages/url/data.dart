import 'dart:convert';
import 'dart:io';
import 'package:mclimate/models/profile.dart';
import 'package:http/http.dart' as http;
import 'package:mclimate/pages/home/page.dart';
import 'package:mclimate/pages/loading/page.dart';
import 'package:mclimate/repositories/rooms.dart';
import 'package:mclimate/services/storage.dart';
import '../../components/error_widget.dart' as error;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UrlData with ChangeNotifier {
  String _url;

  void clear() {
    _url = null;
  }

  set url(String value) {
    _url = value;
  }

  String get url => _url;

  void setUrlMethod(context) async {
    if (url != null) {
      setUrl(url);
    }
    url = null;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoadingPage()),
        (route) => false);
  }
}
