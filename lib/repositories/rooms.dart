import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../services/methods.dart';

Future<http.Response> getRooms() async {
  return await getMethod("rooms");
}

Future<http.Response> getRoom(int id) async {
  return await getMethod("rooms/$id");
}

Future<http.Response> createRoom(String name, String code) async {
  return await postMethod("rooms", jsonEncode({"name": name, "code": code}));
}

Future<http.Response> setTargets(
    int roomID, double targetTemperature, double targetHumidity) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await postMethod(
      "rooms/$roomID/targets",
      jsonEncode({
        "code": preferences.getString('room_$roomID'),
        "targetTemperature": targetTemperature,
        "targetHumidity": targetHumidity,
      }));
}

Future<http.Response> deleteRoom(int id) async {
  return await deleteMethod("rooms", id);
}
