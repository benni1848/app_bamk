import 'package:app_bamk/domain/entities/game_entity.dart';
import 'package:app_bamk/presentation/game_page/widgets/game_tag.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GamePageForm extends StatefulWidget {
  final GameEntity game;

  const GamePageForm({super.key, required this.game});

  @override
  State<GamePageForm> createState() => _GamePageFormState();
}

class _GamePageFormState extends State<GamePageForm> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.game.trailerUrl);
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
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
                    Navigator.pop(context, g); // Hier: Genre zurückgeben
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
        ],
      ),
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
}
