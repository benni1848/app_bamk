import 'package:app_bamk/domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    required super.id,
    required super.title,
    required super.inhalt,
    required super.username,
    required super.mediatype,
    required super.erstelltAm,
    required super.rating,
});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      inhalt: json['inhalt'] ?? '',
      username: json['username'] ?? '',
      mediatype: json['mediatype'] ?? '',
      erstelltAm: json['erstelltAm'] ?? '',
      rating: json['rating'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': mediatype,
      'inhalt': inhalt,
      'username': username,
      'mediatype': mediatype,
      'erstelltAm': erstelltAm,
      'rating': rating,
    };
  }
}
