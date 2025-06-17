import 'package:app_bamk/application/bloc/bloc/auth_bloc.dart';
import 'package:app_bamk/presentation/dashboard_page/dashboard_page.dart';
import 'package:app_bamk/presentation/registration_page/registration_page.dart';
import 'package:app_bamk/presentation/registration_page/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_bamk/root.dart' as app;

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({super.key});

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardPage()),
          );
        }
      },
      builder: (context, authState) {
        return Form(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            children: [
              const SizedBox(height: 80),
              const Center(
                child: Text(
                  "BAMK MEDIENBEWERTUNG",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF80b5e9),
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              CustomTextfield(
                controller: _usernameController,
                hinttext: "Username",
                icon: Icons.person,
                validator: (value) => "1",
                hideText: false,
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: _passwordController,
                hinttext: "Passwort",
                icon: Icons.lock,
                validator: (value) => "1",
                hideText: true,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff80b5e9),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_usernameController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      print(
                          "Fehler: Bitte Benutzernamen und Passwort eingeben!");
                      return;
                    }
                    authBloc.add(UserLoginEvent(
                      username: _usernameController.text.trim(),
                      password: _passwordController.text.trim(),
                    ));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Ladezustand oder Fehlermeldung anzeigen
              if (authState is AuthLoading)
                const Center(child: CircularProgressIndicator())
              else if (authState is AuthFailed)
                const Text(
                  "Login fehlgeschlagen. Bitte überprüfe deine Eingaben.",
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),

              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage()),
                  );
                },
                child: const Text(
                  "Noch kein Konto? Hier Registrieren!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Center(
                child: Image.asset(
                  "assets/test.png",
                  height: 150,
                  width: 150,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
