part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {} //  Startzustand

final class AuthLoading extends AuthState {} //  Zeigt Ladezustand an

final class AuthSuccess extends AuthState {
  final String messageOrToken; //  Speichert den Token oder Erfolgsmeldung

  AuthSuccess(this.messageOrToken);
}

final class AuthFailed
    extends AuthState {} // Fehlgeschlagen (z. B. falsche Login-Daten)
