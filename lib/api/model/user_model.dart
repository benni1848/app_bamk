//* Wandelt die JSON aus der Rest-API in ein Objekt um
import 'package:app_bamk/domain/entities/user_entity.dart';

// UserModel erbt "id, username" von UserEntity
class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.username,
    required super.profilePicture,
  });

  // UserModel aus der Json bauen
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',  // Leere Variable anstelle eines Fehlers melden 
      username: json['username'] ?? '',
      profilePicture: json['profilePicture'] ?? '',
    );
  }

  // Verlinkung von 
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'profilePicture': profilePicture,
    };
  }
}
