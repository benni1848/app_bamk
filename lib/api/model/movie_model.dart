import 'package:app_bamk/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  MovieModel({
    required super.id,
    required super.mediatype,
    required super.name,
    required super.genre,
    required super.director,
    required super.duration,
    required super.published,
    required super.imageUrls,
    required super.trailerUrl,
    required super.description,
    required super.rating,
    required super.coverImage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? '',
      mediatype: json['mediatype'] ?? '',
      name: json['title'] ?? '',
      genre: json['genre'] != null ? List<String>.from(json['genre']) : [],
      director: json['director'] ?? '',
      duration: json['duration'] ?? '',
      published: json['releaseDate'] != null
          ? DateTime.parse(json['releaseDate'])
          : DateTime(2000),
      imageUrls:
          json['imageUrls'] != null ? List<String>.from(json['imageUrls']) : [],
      trailerUrl: json['trailerUrl'] ?? '',
      description: json['description'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      coverImage: json['coverImage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mediatype': mediatype,
      'name': name,
      'genre': genre,
      'director': director,
      'duration': duration,
      'published': published.toIso8601String(),
      'imageUrls': imageUrls,
      'trailerUrl': trailerUrl,
      'description': description,
      'rating': rating,
      'coverImage': coverImage,
    };
  }
}
