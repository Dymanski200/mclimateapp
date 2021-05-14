import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mclimate/models/tokens.dart';
import '../services/storage.dart' as storage;
import 'methods.dart';

Future<http.Response> login(String email, String password) async {
  return await postMethod(
      "account/login", jsonEncode({"email": email, "password": password}));
}

Future<http.Response> getCode(String email) async {
  return await postMethod("account/code", jsonEncode({"email": email}));
}

Future<http.Response> activation(String email, String code) async {
  return await postMethod(
      "account/activation", jsonEncode({"email": email, "code": code}));
}

Future<http.Response> changePassword(
    String email, String code, String password, confirmPassword) async {
  return await postMethod(
      "account/recovery",
      jsonEncode({
        "email": email,
        "code": code,
        "password": password,
        "confirmPassword": confirmPassword,
      }));
}

Future<http.Response> registration(
    String email,
    String password,
    String confirmPassword,
    String surname,
    String name,
    String patronymic) async {
  return await postMethod(
      "account/registration",
      jsonEncode({
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "surname": surname,
        "name": name,
        "patronymic": patronymic,
      }));
}

Future<http.Response> refresh() async {
  final tokens = await storage.getTokens();
  final response =
      await postMethod("account/refresh", jsonEncode(tokens.toJson()));
  if (response != null) {
    if (response.statusCode == HttpStatus.ok)
      storage.setTokens(Tokens.fromJson(jsonDecode(response.body)));
  }
  return response;
}
