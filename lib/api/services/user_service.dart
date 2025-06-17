import 'dart:convert';
import 'package:app_bamk/api/model/user_model.dart';
import 'package:app_bamk/domain/entities/user_entity.dart';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = 'http://10.0.2.2:3000/user';

  static Future<List<UserModel>> fetchUser() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Fehler beim Laden des Benutzers');
    }
  }
}
