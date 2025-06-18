import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl =
      dotenv.env['API_BASE_URL'] ?? 'http://192.168.2.216:3000';
  String? _token;

  // Registrierung eines Benutzers
  Future<bool> registerUser(String username, String password) async {
    print("Registrierung gestartet für: $username");

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      print("API-Antwort: ${response.statusCode}, Body: ${response.body}");

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        _token = data["token"];

        if (_token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("jwt_token", _token!);
        }

        print("Registrierung erfolgreich! Token gespeichert: $_token");
        return true;
      } else {
        print("Fehler bei der Registrierung: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Fehler beim Senden der Anfrage: $e");
      return false;
    }
  }

  // Login eines Benutzers
  Future<String?> loginUser(String username, String password) async {
    print("Login gestartet für: $username");

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      print("API-Antwort: ${response.statusCode}, Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _token = data["token"];

        if (_token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("jwt_token", _token!);
          print("Login erfolgreich! Token gespeichert: $_token");
          return _token;
        }
      } else {
        print("Fehler beim Login: ${response.body}");
      }
    } catch (e) {
      print("Fehler beim Senden der Anfrage: $e");
    }

    return null;
  }

  // Gibt gespeicherten Token zurück
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("jwt_token");
  }

  // Logout-Funktion – löscht gespeicherten Token
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("jwt_token");
    _token = null;
    print("Nutzer wurde abgemeldet! Token gelöscht.");
  }
}
