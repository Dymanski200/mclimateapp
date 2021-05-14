import 'package:shared_preferences/shared_preferences.dart';
import '../models/tokens.dart';

//Устанавливаем адрес сервера
void setUrl(String url) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString('url', url);
}

//Получаем адрес сервера
Future<Uri> getUrl(String controller) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return Uri.parse("${preferences.getString('url')}$controller");
}

//Устанавливаем токены
void setTokens(Tokens tokens) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setString('access_token', tokens.accessToken);
  await preferences.setString('refresh_token', tokens.refreshToken);
}

//Получаем токены
Future<Tokens> getTokens() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return new Tokens(
    preferences.getString('access_token'),
    preferences.getString('refresh_token'),
  );
}
