import 'dart:convert';
import 'package:app_bamk/api/model/user_model.dart';
import 'package:app_bamk/domain/entities/user_entity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  //static const String baseUrl = 'http://10.0.2.2:3000/users';
  static final String? baseUrl = dotenv.env['API_BASE_URL'];

  //* Fetch all Users
  static Future<List<UserModel>> fetchUser() async {
    final response = await http.get(Uri.parse(baseUrl!));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Fehler beim Laden des Benutzers');
    }
  }

  //* Fetch User by ID
  static Future<UserModel> fetchUserById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fehler beim Laden des Benutzers');
    }
  }

  //* Fetch User by username
  static Future<UserModel> fetchUserByUsername(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$username'));

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Fehler beim Laden des Benutzers');
    }
  }
}
