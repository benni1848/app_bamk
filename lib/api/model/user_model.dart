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
      profilePicture: (json['profilePicture'] == null ||
              json['profilePicture'] == '')
          ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png' // Standardbild-URL
          : json['profilePicture'],
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
