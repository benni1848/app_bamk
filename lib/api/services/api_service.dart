import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:3000'; // Emulator Test

  static Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl/api/data'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Fehler beim Laden der Daten: ${response.statusCode}");
    }
  }
}
