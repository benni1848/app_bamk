import 'dart:convert';
import 'package:app_bamk/presentation/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_bamk/root.dart' as app;

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _isTokenValid() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt_token");
    print("Token: $token");

    if (token == null) return false;

    try {
      final parts = token.split(".");
      if (parts.length != 3) return false;

      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("username", payload["username"]);

      final expiry = payload["exp"];
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      print("Token expiry: $expiry, now: $now");

      return expiry != null && expiry > now;
    } catch (e) {
      print("Token-Fehler: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isTokenValid(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text("Fehler: ${snapshot.error}")),
          );
        }

        if (snapshot.data == true) {
          return const app.RootWidget();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
