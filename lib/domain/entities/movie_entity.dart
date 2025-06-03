class MovieEntity {
  final String id;
  final String mediatype;
  final String name;
  final List<String> genre;
  final String director;
  final int duration;
  final DateTime published;
  final List<String> imageUrls;
  final String trailerUrl;
  final String description;
  final double rating;

  MovieEntity({
    required this.id,
    required this.mediatype,
    required this.name,
    required this.genre,
    required this.director,
    required this.duration,
    required this.published,
    required this.imageUrls,
    required this.trailerUrl,
    required this.description,
    required this.rating,
  });
}
