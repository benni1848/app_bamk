import 'package:app_bamk/presentation/registration_page/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class RegistrationPageForm extends StatefulWidget {
  const RegistrationPageForm({super.key});

  @override
  State<RegistrationPageForm> createState() => _RegistrationPageFormState();
}

class _RegistrationPageFormState extends State<RegistrationPageForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            children: [
          const SizedBox(
            height: 80,
          ),
          const Text("Erstelle dir hier ein Konto!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF80b5e9),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(
            height: 40,
          ),
          CustomTextfield(
              controller: _usernameController,
              hinttext: "Username",
              icon: Icons.person,
              validator: (value) {
                return "0";
              },
              hideText: false),
          const SizedBox(
            height: 16,
          ),
          CustomTextfield(
              controller: _passwordController,
              hinttext: "Passwort",
              icon: Icons.lock,
              validator: (value) {
                return "1";
              },
              hideText: true),
          const SizedBox(
            height: 16,
          ),
          CustomTextfield(
              controller: _passwordRepeatController,
              hinttext: "Passwort Wiederholen",
              icon: Icons.lock,
              validator: (value) {
                return "0";
              },
              hideText: true),
          const SizedBox(
            height: 32,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF80b5e9),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Registrieren",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
            child: const Text(
              "Du hast bereits ein Konto? Hier anmelden!",
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
        ]));
  }
}
