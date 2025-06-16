import 'package:app_bamk/domain/entities/music_entity.dart';
import 'package:app_bamk/presentation/music_page/widgets/music_tag.dart';
import 'package:flutter/material.dart';

class MusicPageForm extends StatelessWidget {
  final MusicEntity music;

  const MusicPageForm({super.key, required this.music});

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
          Text(
            music.description,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 24),
          _buildDetail("Artist(s)", music.artist.join(", ")),
          _buildDetail("Album", music.album),
          _buildDetail("Label", music.label),
          _buildDetail("Medium", music.mediatype),
          _buildDetail("Explizit", music.explicit ? "Ja" : "Nein"),
          _buildDetail("Veröffentlichung",
              "${music.releaseDate.day}.${music.releaseDate.month}.${music.releaseDate.year}"),
          _buildDetail("Bewertung", "${music.rating} / 10"),
          _buildDetail("Dauer", "${music.duration} Sekunden"),
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
