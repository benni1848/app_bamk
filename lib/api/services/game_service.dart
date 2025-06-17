import 'dart:convert';
import 'package:app_bamk/api/model/game_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GameService {
  static final String? baseUrl = dotenv.env['API_BASE_URL'] != null
      ? '${dotenv.env['API_BASE_URL']}/games'
      : null;

  static Future<List<GameModel>> fetchGames() async {
    final response = await http.get(Uri.parse(baseUrl!));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => GameModel.fromJson(json)).toList();
    } else {
      throw Exception('Fehler beim Laden der Spiele');
    }
  }
}
