import 'dart:convert';
import 'package:app_bamk/api/model/movie_model.dart';
import 'package:http/http.dart' as http;
import 'package:app_bamk/domain/entities/movie_entity.dart';
//import 'package:app_bamk/config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DatabaseService {
  /// Get Movie by ID
  static Future<MovieEntity?> fetchMovieFromApi(String movieId) async {
    try {
      final baseUrl = dotenv.env['BASE_API_URL'];
      if (baseUrl == null) throw Exception("BASE_API_URL nicht gesetzt");

      final response = await http.get(Uri.parse("$baseUrl/movies/$movieId"));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return MovieModel.fromJson(jsonData);
      } else {
        print("Fehler: Status ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Fehler bei API-Abfrage: $e");
      return null;
    }
  }

  /// Get every Movie
  static Future<List<MovieEntity>> fetchAllMovies() async {
    try {
      final baseUrl = dotenv.env['BASE_API_URL'];
      if (baseUrl == null) throw Exception("BASE_API_URL nicht gesetzt");

      final response = await http.get(Uri.parse("$baseUrl/movies"));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List;
        return jsonData.map((movie) => MovieModel.fromJson(movie)).toList();
      } else {
        print("Fehler: Status ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Fehler bei API-Abfrage: $e");
      return [];
    }
  }
}
