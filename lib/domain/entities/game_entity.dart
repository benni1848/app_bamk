class GameEntity {
  final String id;
  final String mediatype;
  final String title;
  final List<String> genre;
  final String publisher;
  final String developer;
  final DateTime releaseDate;
  final List<String> platforms;
  final List<String> imageUrls;
  final String trailerUrl;
  final String description;
  final double rating;
  final String coverImage;

  GameEntity({
    required this.id,
    required this.mediatype,
    required this.title,
    required this.genre,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.platforms,
    required this.imageUrls,
    required this.trailerUrl,
    required this.description,
    required this.rating,
    required this.coverImage,
  });
}
