import 'dart:convert';
import 'package:app_bamk/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:app_bamk/domain/entities/movie_entity.dart';
import 'package:app_bamk/presentation/film_page/widgets/movie_tag.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FilmPageForm extends StatefulWidget {
  final MovieEntity movie;
  final String username;

  const FilmPageForm({super.key, required this.movie, required this.username});

  @override
  State<FilmPageForm> createState() => _FilmPageFormState();
}

class _OneToTenInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;

    if (text.isEmpty) return newValue;

    final value = int.tryParse(text);
    if (value == null || value < 1 || value > 10) {
      return oldValue;
    }

    return newValue;
  }
}

class _FilmPageFormState extends State<FilmPageForm> {
  late YoutubePlayerController _youtubeController;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _ratingController = TextEditingController();
  List<Map<String, dynamic>> _comments = [];
  bool _isLoadingComments = true;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.movie.trailerUrl);
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
    _fetchComments();
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _fetchComments() async {
    try {
      final baseUrl = dotenv.env['API_BASE_URL'];
      final response = await http.get(Uri.parse('$baseUrl/comments'));
      final all = List<Map<String, dynamic>>.from(jsonDecode(response.body));
      final filtered = all
          .where((c) =>
              c['mediatype'].toString() == '2' &&
              c['id'].toString() == widget.movie.id.toString())
          .toList();
      filtered.sort((a, b) => DateTime.parse(b['erstelltAm'])
          .compareTo(DateTime.parse(a['erstelltAm'])));
      setState(() {
        _comments = filtered;
        _isLoadingComments = false;
      });
    } catch (_) {
      setState(() => _isLoadingComments = false);
    }
  }

  Future<void> _submitComment() async {
    final username = context.read<UserProvider>().username ?? "Anonym";
    final comment = {
      "title": _titleController.text.trim(),
      "inhalt": _contentController.text.trim(),
      "id": widget.movie.id.toString(),
      "username": username,
      "rating": int.tryParse(_ratingController.text.trim()) ?? 0
    };

    try {
      final baseUrl = dotenv.env['API_BASE_URL'];
      final url = Uri.parse('$baseUrl/comments/movies');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(comment),
      );
      print("Statuscode: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        _titleController.clear();
        _contentController.clear();
        _ratingController.clear();
        await _fetchComments();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Kommentar erfolgreich gesendet!")),
        );
      } else {
        throw Exception("Fehlerhafte Antwort vom Server");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fehler beim Senden: $e")),
      );
    }

  }

  Widget _buildDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white10,
      border: const OutlineInputBorder(),
      labelStyle: const TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[700],
              ),
              child: Text(
                movie.name,
                style: const TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child:
                Image.network(movie.coverImage, height: 200, fit: BoxFit.cover),
          ),
          const SizedBox(height: 20),
          Center(
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              alignment: WrapAlignment.center,
              children: movie.genre.map((g) {
                return MovieTag(
                  text: g,
                  onPressed: () => Navigator.pop(context, g),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          Text(movie.description,
              style: const TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 24),
          _buildDetail("Regisseur", movie.director),
          _buildDetail("Dauer", "${movie.duration} Minuten"),
          _buildDetail("Veröffentlichung",
              "${movie.published.day}.${movie.published.month}.${movie.published.year}"),
          _buildDetail("Bewertung", "${movie.rating} / 10"),
          const SizedBox(height: 24),
          const Text("Trailer ansehen:",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          YoutubePlayer(
            controller: _youtubeController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
          ),
          const SizedBox(height: 24),
          const Text("Kommentar schreiben:",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            controller: _titleController,
            decoration: _inputDecoration("Titel"),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _contentController,
            maxLines: 3,
            decoration: _inputDecoration("Kommentar"),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _ratingController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
              _OneToTenInputFormatter(),
            ],
            decoration: _inputDecoration("Rating"),
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: _submitComment,
            child: const Text("Absenden"),
          ),
          const SizedBox(height: 24),
          const Text("Kommentare:",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          if (_isLoadingComments)
            const Center(child: CircularProgressIndicator())
          else if (_comments.isEmpty)
            const Text("Noch keine Kommentare vorhanden.",
                style: TextStyle(color: Colors.white70))
          else
            ..._comments.map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c['title'] ?? '',
                            style: const TextStyle(
                                color: Color(0xFF80B5E9),
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(c['inhalt'] ?? '',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text("- ${c['username'] ?? 'unbekannt'}",
                            style: const TextStyle(
                                color: Colors.white38, fontSize: 12)),
                      ],
                    ),
                  ),
                )),
        ],
      ),
    );
  }
}
