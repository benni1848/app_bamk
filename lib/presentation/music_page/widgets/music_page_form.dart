import 'dart:convert';
import 'package:app_bamk/providers/user_provider.dart';
import 'package:app_bamk/domain/entities/music_entity.dart';
import 'package:app_bamk/presentation/music_page/widgets/music_tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MusicPageForm extends StatefulWidget {
  final MusicEntity music;

  const MusicPageForm(
      {super.key, required this.music, required String username});

  @override
  State<MusicPageForm> createState() => _MusicPageFormState();
}

class _MusicPageFormState extends State<MusicPageForm> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  List<Map<String, dynamic>> _comments = [];
  bool _isLoadingComments = true;
  String? _userVote; // "like", "dislike", oder null
  bool _isVoting = false;

  Future<void> _loadUserVote() async {
    final prefs = await SharedPreferences.getInstance();
    final vote = prefs.getString('music_vote_${widget.music.id}');
    setState(() {
      _userVote = vote;
    });
  }

  Future<void> _sendVoteToBackend(String? voteType) async {
    setState(() => _isVoting = true);
    final username = context.read<UserProvider>().username ?? "Anonym";
    final baseUrl = dotenv.env['API_BASE_URL'];
    final url = Uri.parse('$baseUrl/likes/post');

    int vote;
    if (voteType == "like") {
      vote = 1;
    } else if (voteType == "dislike") {
      vote = -1;
    } else {
      vote = 0; // Zum Löschen
    }

    final payload = {
      "username": username,
      "id": widget.music.id.toString(),
      "vote": vote.toString(),
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Lokale Speicherung updaten
        final prefs = await SharedPreferences.getInstance();
        if (vote == 0) {
          await prefs.remove('music_vote_${widget.music.id}');
          setState(() => _userVote = null);
        } else {
          await prefs.setString('music_vote_${widget.music.id}', voteType!);
          setState(() => _userVote = voteType);
        }

        // Feedback optional
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Vote erfolgreich gesendet")),
        );
      } else {
        throw Exception("Vote fehlgeschlagen: ${response.body}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Fehler beim Voten: $e")),
      );
    } finally {
      setState(() => _isVoting = false);
    }
  }

  Future<void> _vote(String value) async {
    if (_userVote == value) {
      // Vote zurückziehen (entspricht vote = 0 im Backend)
      await _sendVoteToBackend(null);
    } else {
      // Neuer Vote oder Änderung
      await _sendVoteToBackend(value);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchComments();
    _loadUserVote();
  }

  @override
  void dispose() {
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
              c['mediatype'].toString() == '3' &&
              c['id'].toString() == widget.music.id.toString())
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
      "id": widget.music.id.toString(),
      "username": username,
    };

    try {
      final baseUrl = dotenv.env['API_BASE_URL'];
      final url = Uri.parse('$baseUrl/comments/music');
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
          Text("$label: ",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final music = widget.music;

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
                music.title,
                style: const TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Image.network(
              music.coverImage,
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
              children: music.genre.map((g) {
                return MusicTag(
                  text: g,
                  onPressed: () {
                    Navigator.pop(context, g);
                  },
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          Text(music.description,
              style: const TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 24),
          _buildDetail("Artist(s)", music.artist.join(", ")),
          _buildDetail("Album", music.album),
          _buildDetail("Label", music.label),
          _buildDetail("Medium", music.mediatype),
          _buildDetail("Explizit", music.explicit ? "Ja" : "Nein"),
          _buildDetail("Veröffentlichung",
              "${music.releaseDate.day}.${music.releaseDate.month}.${music.releaseDate.year}"),
          _buildDetail("Likes", "${music.rating} "),
          _buildDetail("Dauer", "${music.duration} Sekunden"),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _isVoting ? null : () => _vote("like"),
                icon: Icon(
                  Icons.thumb_up,
                  color: _userVote == "like" ? Colors.green : Colors.white70,
                  size: 32,
                ),
              ),
              const SizedBox(width: 24),
              IconButton(
                onPressed: _isVoting ? null : () => _vote("dislike"),
                icon: Icon(
                  Icons.thumb_down,
                  color: _userVote == "dislike" ? Colors.red : Colors.white70,
                  size: 32,
                ),
              ),
            ],
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
