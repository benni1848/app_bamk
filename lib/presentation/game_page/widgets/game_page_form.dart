import 'dart:convert';
import 'package:app_bamk/providers/user_provider.dart';
import 'package:app_bamk/domain/entities/game_entity.dart';
import 'package:app_bamk/presentation/game_page/widgets/game_tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GamePageForm extends StatefulWidget {
  final GameEntity game;

  const GamePageForm({super.key, required this.game, required String username});

  @override
  State<GamePageForm> createState() => _GamePageFormState();
}

class _GamePageFormState extends State<GamePageForm> {
  late YoutubePlayerController _youtubeController;
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  List<Map<String, dynamic>> _comments = [];
  bool _isLoadingComments = true;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.game.trailerUrl);
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
              c['mediatype'].toString() == '1' &&
              c['id'].toString() == widget.game.id.toString())
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
      "id": widget.game.id.toString(),
      "username": username,
    };

    try {
      final baseUrl = dotenv.env['API_BASE_URL'];
      final url = Uri.parse('$baseUrl/comments/games');
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(comment),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _titleController.clear();
        _contentController.clear();
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

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white10,
      border: const OutlineInputBorder(),
      labelStyle: const TextStyle(color: Colors.white),
    );
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
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = widget.game;

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
                game.title,
                style: const TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Image.network(
              game.coverImage,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              alignment: WrapAlignment.center,
              children: game.genre.map((g) {
                return GameTag(
                  text: g,
                  onPressed: () {
                    Navigator.pop(context, g);
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            game.description,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 24),
          _buildDetail("Publisher", game.publisher),
          _buildDetail("Medium", game.mediatype),
          _buildDetail("Developer", game.developer),
          _buildDetail("Veröffentlichung",
              "${game.releaseDate.day}.${game.releaseDate.month}.${game.releaseDate.year}"),
          _buildDetail("Bewertung", "${game.rating} / 10"),
          const SizedBox(height: 24),
          const Text(
            "Trailer ansehen:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          YoutubePlayer(
            controller: _youtubeController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.blueAccent,
          ),
          const SizedBox(height: 24),
          const Text(
            "Kommentar schreiben:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
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
          ElevatedButton(
            onPressed: _submitComment,
            child: const Text("Absenden"),
          ),
          const SizedBox(height: 24),
          const Text(
            "Kommentare:",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (_isLoadingComments)
            const Center(child: CircularProgressIndicator())
          else if (_comments.isEmpty)
            const Text(
              "Noch keine Kommentare vorhanden.",
              style: TextStyle(color: Colors.white70),
            )
          else
            ..._comments
                .map((c) => Padding(
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
                    ))
                .toList(),
        ],
      ),
    );
  }
}
