class MusicEntity {
  final String id;
  final String mediatype;
  final String title;
  final List<String> genre;
  final List<String> artist;
  final String album;
  final String label;
  final int duration;
  final DateTime releaseDate;
  final List<String> imageUrls;
  final String description;
  final int rating;
  final String coverImage;
  final String imageURL;
  final bool explicit;

  MusicEntity({
    required this.id,
    required this.mediatype,
    required this.title,
    required this.genre,
    required this.artist,
    required this.album,
    required this.label,
    required this.duration,
    required this.releaseDate,
    required this.imageUrls,
    required this.description,
    required this.rating,
    required this.coverImage,
    required this.imageURL,
    required this.explicit,
  });
}
