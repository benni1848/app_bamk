import 'dart:convert';
import 'package:app_bamk/api/model/comment_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CommentService {
  static final String? baseUrl = dotenv.env['API_BASE_URL'];

  //* Fetch all Comments
  static Future<List<CommentModel>> fetchComment() async {
    final response = await http.get(Uri.parse('$baseUrl/comments'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => CommentModel.fromJson(json)).toList();
    } else {
      throw Exception('Fehler beim Laden der Kommentare');
    }
  }

   //* Fetch all Comments
  static Future<List<CommentModel>> fetchCommentLast() async {
    final response = await http.get(Uri.parse('$baseUrl/comments/last10'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => CommentModel.fromJson(json)).toList();
    } else {
      throw Exception('Fehler beim Laden der letzten 10 Kommentare');
    }
  }

  //* Fetch Comment by username
  static Future<List<CommentModel>> fetchCommentByUsername(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/comments/$username'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => CommentModel.fromJson(json)).toList();
    } else {
      throw Exception('Fehler beim Laden der Kommentare');
    }
  }
}