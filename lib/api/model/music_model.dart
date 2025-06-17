import 'package:app_bamk/domain/entities/music_entity.dart';

class MusicModel extends MusicEntity {
  MusicModel({
    required super.id,
    required super.mediatype,
    required super.title,
    required super.artist,
    required super.album,
    required super.label,
    required super.genre,
    required super.duration,
    required super.releaseDate,
    required super.description,
    required super.rating,
    required super.coverImage,
    required super.imageURL,
    required super.explicit,
    required super.imageUrls,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      id: json['id'] ?? '',
      mediatype: json['mediatype'] ?? '',
      title: json['title'] ?? '',
      artist: json['artist'] != null ? List<String>.from(json['artist']) : [],
      album: json['album'] ?? '',
      label: json['label'] ?? '',
      genre: json['genre'] != null ? List<String>.from(json['genre']) : [],
      duration: json['duration'] ?? 0,
      releaseDate: json['releaseDate'] != null
          ? DateTime.parse(json['releaseDate'])
          : DateTime(2000),
      description: json['description'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      coverImage: json['coverImage'] ?? '',
      imageURL: json['imageURL'] ?? '',
      explicit: json['explicit']?.toString().toLowerCase() == 'true',
      imageUrls:
          json['imageUrls'] != null ? List<String>.from(json['imageUrls']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mediatype': mediatype,
      'title': title,
      'artist': artist,
      'album': album,
      'label': label,
      'genre': genre,
      'duration': duration,
      'releaseDate': releaseDate.toIso8601String(),
      'description': description,
      'rating': rating,
      'coverImage': coverImage,
      'imageURL': imageURL,
      'explicit': explicit,
      'imageUrls': imageUrls,
    };
  }
}
