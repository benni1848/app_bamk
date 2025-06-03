import 'package:app_bamk/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:app_bamk/data/test_movie.dart';
import 'package:app_bamk/presentation/film_page/widgets/movie_tag.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FilmPageForm extends StatefulWidget {
  const FilmPageForm({super.key});

  @override
  State<FilmPageForm> createState() => _FilmPageFormState();
}

class _FilmPageFormState extends State<FilmPageForm> {
  final MovieEntity movie = testMovie;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Konnte Link nicht öffnen')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              movie.imageUrls.first,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            alignment: WrapAlignment.center,
            children: movie.genre.map(
              (g) {
                return MovieTag(
                  text: g,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Genre: $g')),
                    );
                  },
                );
              },
            ).toList(),
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
          _buildDetail("Veröffentlichung", "${movie.published.year}"),
          _buildDetail("Bewertung", "${movie.rating} / 10"),
          const SizedBox(height: 24),
          Text(
            "Trailer ansehen:",
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: YoutubePlayer.convertUrlToId(movie.trailerUrl)!,
              flags: const YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            ),
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
