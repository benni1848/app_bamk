import 'dart:convert';
import 'package:app_bamk/api/model/movie_model.dart';
import 'package:app_bamk/domain/entities/movie_entity.dart';
import 'package:http/http.dart' as http;

class MovieService {
  static const String baseUrl = 'http://10.0.2.2:3000/movies';

  static Future<List<MovieModel>> fetchMovies() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Fehler beim Laden der Filme');
    }
  }
}
