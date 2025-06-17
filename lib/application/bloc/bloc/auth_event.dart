part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

/// Event für Login
class UserLoginEvent extends AuthEvent {
  final String username;
  final String password;

  UserLoginEvent({required this.username, required this.password});
}

/// Event für Registrierung ohne E-Mail!
class UserRegisterEvent extends AuthEvent {
  final String username;
  final String password;

  UserRegisterEvent({required this.username, required this.password});
}

/// Event für Logout
class UserLogoutEvent extends AuthEvent {}
