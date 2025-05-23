import 'package:app_bamk/presentation/registration_page/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({super.key});

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        children: [
          const SizedBox(
            height: 80,
          ),
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
              controller: _emailController,
              hinttext: "Username",
              icon: Icons.person,
              validator: (value) {
                return "1";
              },
              hideText: false),
          const SizedBox(height: 16),
          CustomTextfield(
              controller: _passwordController,
              hinttext: "Passwort",
              icon: Icons.lock,
              validator: (value) {
                return "1";
              },
              hideText: true),
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
              onPressed: () {},
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/registration");
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
  }
}
