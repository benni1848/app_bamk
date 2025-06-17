import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_bamk/application/bloc/bloc/auth_bloc.dart';
import 'package:app_bamk/api/services/auth_service.dart';
import 'package:app_bamk/presentation/login_page/widgets/login_page_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
          authService: AuthService()), //  AuthBloc mit AuthService übergeben
      child: Scaffold(
        backgroundColor: const Color(0xFF1a1a1a),
        body: const LoginPageForm(),
      ),
    );
  }
}
