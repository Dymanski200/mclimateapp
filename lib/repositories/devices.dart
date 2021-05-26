import 'dart:convert';

import 'package:http/http.dart' as http;
import '../services/methods.dart';

Future<http.Response> getDevices(int roomID) async {
  return await getMethod("rooms/$roomID/devices");
}

Future<http.Response> createDevice(int roomID, String name) async {
  return await postMethod(
      "devices", jsonEncode({"roomID": roomID, "name": name}));
}

Future<http.Response> deleteDevice(int id) async {
  return await deleteMethod("devices", id);
}
