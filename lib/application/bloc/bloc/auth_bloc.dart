import 'package:bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:app_bamk/api/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<UserLoginEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final token = await authService.loginUser(
          event.username,
          event.password,
        );

        if (token != null) {
          await _storage.write(
              key: 'jwt_token', value: token); // Create Token if not exist
          emit(AuthSuccess(token));
        } else {
          emit(AuthFailed());
        }
      } catch (e) {
        print("Fehler im Login Bloc: $e");
        emit(AuthFailed());
      }
    });

    on<UserRegisterEvent>((event, emit) async {
      emit(AuthLoading());

      try {
        final success = await authService.registerUser(
          event.username,
          event.password,
        );

        if (success) {
          final token = await authService.getToken();
          if (token != null) {
            await _storage.write(
                key: 'jwt_token', value: token); //Write Token to Memory
          }
          emit(AuthSuccess(token ?? "Registrierung erfolgreich"));
        } else {
          emit(AuthFailed());
        }
      } catch (e) {
        print("Fehler im Register Bloc: $e");
        emit(AuthFailed());
      }
    });

    on<UserLogoutEvent>((event, emit) async {
      try {
        await _storage.delete(key: 'jwt_token'); // Delete on Logout
        await authService.logout();
        emit(AuthInitial());
      } catch (e) {
        print("Fehler im Logout Bloc: $e");
        emit(AuthFailed());
      }
    });
  }
}
