import 'dart:convert';
import 'package:app_bamk/api/model/music_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MusicService {
  static final String? baseUrl = dotenv.env['API_BASE_URL'];

  // Fetch all music
  static Future<List<MusicModel>> fetchMusic() async {
    final response = await http.get(Uri.parse('$baseUrl/music'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => MusicModel.fromJson(json)).toList();
      
    } else {
      throw Exception('Fehler beim Laden der Musiktitel');
    }
  }

  // Fetch top 10 music
  static Future<List<MusicModel>> fetchtop10() async {
    final response = await http.get(Uri.parse('$baseUrl/music/top10'));

    // Check baseURL
    if (baseUrl == null) {
      throw Exception('API_BASE_URL aus .env nicht geladen!');
    }
    

    // Request for music
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => MusicModel.fromJson(json)).toList();
    } else {
      throw Exception('Fehler beim Laden der Top 10 Songs');
    }
  }
}