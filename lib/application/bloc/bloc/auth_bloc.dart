import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    Future sleep1() {
      return Future.delayed(const Duration(seconds: 2), () => "1");
    }

    on<AuthEvent>((event, emit) async {
      emit(AuthLoading());
      //do something
      await sleep1(); //fake request for testing
      //get advice
      emit(AuthSuccess());
    });
  }
}
