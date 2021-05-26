import 'dart:convert';

import 'package:http/http.dart' as http;
import '../services/methods.dart';

Future<http.Response> getRules(int deviceID) async {
  return await getMethod("devices/$deviceID/rules");
}

Future<http.Response> createRule(
  int deviceID,
  bool temperature,
  double offset,
  String command,
  String status,
) async {
  return await postMethod(
      "rules",
      jsonEncode({
        "deviceID": deviceID,
        "temperature": temperature,
        "offset": offset,
        "command": command,
        "status": status,
      }));
}

Future<http.Response> deleteRule(int id) async {
  return await deleteMethod("rules", id);
}
