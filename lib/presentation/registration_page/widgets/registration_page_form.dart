import 'package:flutter/material.dart';

class RegistrationPageForm extends StatefulWidget {
  const RegistrationPageForm({super.key});

  @override
  State<RegistrationPageForm> createState() => _RegistrationPageFormState();
}

class _RegistrationPageFormState extends State<RegistrationPageForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            children: [
          const Text(
            "Erstelle dir hier ein Konto!",
            style: TextStyle(fontSize: 40),
          ),
          TextFormField(
            controller: _emailController,
            style: const TextStyle(color: Color(0xff3f4b3b)),
            decoration: InputDecoration(
              hintText: "E-Mail",
              filled: true,
              fillColor: const Color(0x4f06402b),
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
          SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _passwordController,
            style: const TextStyle(color: Color(0xff3f4b3b)),
            decoration: InputDecoration(
              hintText: "Passwort",
              filled: true,
              fillColor: const Color(0x4f06402b),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.lock, color: Colors.black),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Bitte E-Mail eingeben';
              }
              return null;
            },
          ),
        ]));
  }
}
