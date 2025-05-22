import 'package:app_bamk/presentation/registration_page/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class RegistrationPageForm extends StatefulWidget {
  const RegistrationPageForm({super.key});

  @override
  State<RegistrationPageForm> createState() => _RegistrationPageFormState();
}

class _RegistrationPageFormState extends State<RegistrationPageForm> {
  final TextEditingController _emailController = TextEditingController();
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
          const Text("Erstelle dir hier ein Konto!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff06402b),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: _emailController,
            style: const TextStyle(color: Color(0xff3f4b3b)),
            decoration: InputDecoration(
              hintText: "Username",
              filled: true,
              fillColor: const Color(0x4f06402b),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.person, color: Colors.black),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Bitte einen Usernamen eingeben';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _usernameController,
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
          const SizedBox(
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
              if (value!.length <= 6 || value.isEmpty) {
                return 'Passwort zu kurz';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _passwordRepeatController,
            style: const TextStyle(color: Color(0xff3f4b3b)),
            decoration: InputDecoration(
              hintText: "Passwort wiederholen",
              filled: true,
              fillColor: const Color(0x4f06402b),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.lock, color: Colors.black),
            ),
            validator: (value) {
              if (value!.length <= 6 || value.isEmpty) {
                return 'Passwort zu kurz';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 30, 1),
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
          CustomTextfield(
            hideText: true,
            hinttext: "test",
            textcolor: Colors.black,
            fillcolor: const Color(0x4f06402b),
            icon: Icons.person,
            validator: (value) {
              return null;
            },
          ),
        ]));
  }
}
