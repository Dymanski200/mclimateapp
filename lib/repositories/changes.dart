import 'package:http/http.dart' as http;
import '../services/methods.dart';

Future<http.Response> getChanges(int roomID) async {
  return await getMethod("rooms/$roomID/changes");
}
