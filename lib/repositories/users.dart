import 'package:http/http.dart' as http;
import '../services/methods.dart';

Future<http.Response> getUsers() async {
  return await getMethod("users");
}

Future<http.Response> deleteUser(int id) async {
  return await deleteMethod("users", id);
}
