import 'package:flutter/material.dart';

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({super.key});

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        children: [
          const SizedBox(
            height: 80,
          ),
          const Center(
            child: Text(
              "BAMK-MEDIENBEWERTUNG",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF80b5e9),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),
          TextFormField(
            controller: _emailController,
            style: const TextStyle(color: Color(0xff3f4b3b)),
            decoration: InputDecoration(
              hintText: "E-Mail",
              filled: true,
              fillColor: const Color(0xFFd9d9d9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.email, color: Colors.black),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Bitte E-Mail eingeben';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Passwort",
              filled: true,
              fillColor: const Color(0xffd9d9d9),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.lock, color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
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
