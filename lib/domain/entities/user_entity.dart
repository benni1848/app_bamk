//* Beschreibt den Aufbau eines Users innerhalb der App

// Klasse - UserEntity
class UserEntity {
  final String id;
  final String username;
  final String profilePicture;

// Konstruktor für die Klasse UserEntity
  UserEntity({
    required this.id,
    required this.username,  
    required this.profilePicture,
  });
}
