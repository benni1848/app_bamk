import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:app_bamk/api/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService; // Fügt AuthService für API-Aufrufe hinzu

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<UserLoginEvent>((event, emit) async {
      emit(AuthLoading()); //  Zeigt Ladezustand an

      try {
        final token = await authService.loginUser(
            event.username, event.password); // API-Aufruf
        emit(AuthSuccess(
            token as String)); // Erfolgreicher Login (Token wird gespeichert)
      } catch (_) {
        emit(AuthFailed()); // Fehler behandeln
      }
    });

    on<UserRegisterEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final success = await authService.registerUser(
            event.username, event.password); // API-Aufruf
        if (success) {
          emit(AuthSuccess("Registrierung erfolgreich!"));
        } else {
          emit(AuthFailed());
        }
      } catch (_) {
        emit(AuthFailed());
      }
    });

    on<UserLogoutEvent>((event, emit) async {
      await authService.logout(); // Entfernt das Token
      emit(AuthInitial()); // Zurücksetzen des States nach Logout
    });
  }
}
