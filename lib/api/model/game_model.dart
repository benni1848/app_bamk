import 'package:app_bamk/domain/entities/game_entity.dart';

class GameModel extends GameEntity {
  GameModel({
    required super.id,
    required super.mediatype,
    required super.title,
    required super.genre,
    required super.publisher,
    required super.developer,
    required super.releaseDate,
    required super.platforms,
    required super.imageUrls,
    required super.trailerUrl,
    required super.description,
    required super.rating,
    required super.coverImage,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'].toString(),
      mediatype: json['mediatype'].toString(),
      title: json['title'].toString(),
      genre: List<String>.from(json['genre'] ?? []),
      publisher: json['publisher'].toString(),
      developer: json['developer'].toString(),
      releaseDate: DateTime.parse(json['releaseDate']),
      platforms: List<String>.from(json['platforms'] ?? []),
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      trailerUrl: json['trailerUrl'].toString(),
      description: json['description'].toString(),
      rating: (json['rating'] as num).toDouble(),
      coverImage: json['coverImage'].toString(),
    );
  }
}
