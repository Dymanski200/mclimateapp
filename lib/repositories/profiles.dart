import 'dart:convert';

import 'package:http/http.dart' as http;
import '../services/methods.dart';

Future<http.Response> getProfiles() async {
  return await getMethod("account/profiles");
}

Future<http.Response> createProfile(
    String name, double targetTemperature, double targetHumidity) async {
  return await postMethod(
      "profiles",
      jsonEncode({
        "name": name,
        "targetTemperature": targetTemperature,
        "targetHumidity": targetHumidity,
      }));
}

Future<http.Response> deleteProfile(int id) async {
  return await deleteMethod("profiles", id);
}
