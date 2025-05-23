part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

///event when user log in
class UserLoginEvent extends AuthEvent {}

class UserRegistrationEvent extends AuthEvent {}
