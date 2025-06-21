import 'dart:convert';
import 'package:app_bamk/api/model/movie_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MovieService {
  static final String? baseUrl = dotenv.env['API_BASE_URL'];
  final url = Uri.parse('$baseUrl/comments');

  // Fetch all movies
  static Future<List<MovieModel>> fetchMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movies'));

    if (baseUrl == null) {
      throw Exception('API_BASE_URL aus .env nicht geladen!');
    }

    //final url = Uri.parse('$baseUrl/movies');
    //final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Fehler beim Laden der Filme');
    }
  }

  // Fetch top 10 movies
  static Future<List<MovieModel>> fetchtop10() async {
    final response = await http.get(Uri.parse('$baseUrl/movies/top10'));

    // Check baseURL
    if (baseUrl == null) {
      throw Exception('API_BASE_URL aus .env nicht geladen!');
    }
    

    // Request for movies
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => MovieModel.fromJson(json)).toList();
    } else {
      throw Exception('Fehler beim Laden der Top 10 Filme');
    }
  }
  
}
