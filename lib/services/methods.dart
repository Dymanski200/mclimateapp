import 'package:http/http.dart' as http;
import 'dart:io';
import 'storage.dart' as storage;
import 'account.dart' as account;

Future<http.Response> postMethod(String controller, String json) async {
  await Future.delayed(Duration(milliseconds: 500));
  final url = await storage.getUrl("/api/$controller");
  var tokens = await storage.getTokens();
  http.Response response;
  for (int i = 0; i < 2; i++) {
    try {
      print("$url\n$json");
      response = await http.post(
        url,
        body: json,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${tokens.accessToken}",
        },
      );
      print(response.statusCode);
      if ((response.statusCode == HttpStatus.unauthorized) &&
          (controller == "account/refresh")) {
        print("ban");
        return response;
      }
      if (response.statusCode != HttpStatus.unauthorized)
        break;
      else {
        await account.refresh();
        tokens = await storage.getTokens();
      }
    } catch (er) {
      return null;
    }
  }
  return response;
}

Future<http.Response> getMethod(String controller) async {
  await Future.delayed(Duration(milliseconds: 500));
  final url = await storage.getUrl("/api/$controller");
  var tokens = await storage.getTokens();
  http.Response response;
  for (int i = 0; i < 2; i++) {
    try {
      print("$url");
      response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${tokens.accessToken}",
        },
      );
      print(response.statusCode);
      if (response.statusCode != HttpStatus.unauthorized)
        break;
      else {
        await account.refresh();
        tokens = await storage.getTokens();
      }
    } catch (er) {
      return null;
    }
  }
  return response;
}
