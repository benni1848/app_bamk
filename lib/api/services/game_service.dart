import 'dart:convert';
import 'package:app_bamk/api/model/game_model.dart';
import 'package:http/http.dart' as http;

class GameService {
  static const String baseUrl = 'http://192.168.2.216:3000/games';

  static Future<List<GameModel>> fetchGames() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => GameModel.fromJson(json)).toList();
    } else {
      throw Exception('Fehler beim Laden der Spiele');
    }
  }
}
