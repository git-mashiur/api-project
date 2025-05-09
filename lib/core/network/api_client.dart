
import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseApiClient {
Future<dynamic> get({required String endPoint}) async {
final response = await http.get(Uri.parse(endPoint));
if (response.statusCode == 200) {
return jsonDecode(response.body);
} else {
throw Exception('Failed to load data from $endPoint');
}
}
}