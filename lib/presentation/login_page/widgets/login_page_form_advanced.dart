//LoginPage with BackendConnection
/*import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({super.key});

  @override
  _LoginPageFormState createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;

  Future<void> login() async {
    final response = await http.post(
      Uri.parse("http://localhost:3000/login"), // Backend Url here
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": usernameController.text,
        "password": passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Login erfolgreich! Token: ${data['token']}");
    } else {
      setState(() {
        errorMessage = "Login fehlgeschlagen. Bitte überprüfe deine Eingaben.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(labelText: "Benutzername"),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: "Passwort"),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: login,
            child: const Text("Login"),
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    );
  }
}*/
