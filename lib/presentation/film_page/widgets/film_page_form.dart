import 'package:app_bamk/domain/entities/movie_entity.dart';
import 'package:app_bamk/presentation/film_page/widgets/movie_tag.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FilmPageForm extends StatefulWidget {
  final MovieEntity movie;

  const FilmPageForm({super.key, required this.movie});

  @override
  State<FilmPageForm> createState() => _FilmPageFormState();
}

class _FilmPageFormState extends State<FilmPageForm> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayer.convertUrlToId(widget.movie.trailerUrl);
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
            child: Image.network(
              movie.coverImage,
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
              children: movie.genre.map((g) {
                return MovieTag(
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
            movie.description,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 24),
          _buildDetail("Regisseur", movie.director),
          _buildDetail("Medium", movie.mediatype),
          _buildDetail("Dauer", "${movie.duration} Minuten"),
          _buildDetail("Veröffentlichung",
              "${movie.published.day}.${movie.published.month}.${movie.published.year}"),
          _buildDetail("Bewertung", "${movie.rating} / 10"),
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
