import 'package:http/http.dart' as http;
import '../services/methods.dart';

Future<http.Response> getRooms() async {
  return await getMethod("rooms");
}

Future<http.Response> getMyRooms() async {
  return await getMethod("rooms/my");
}
