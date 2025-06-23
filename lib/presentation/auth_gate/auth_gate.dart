import 'dart:convert';
import 'package:app_bamk/presentation/dashboard_page/dashboard_page.dart';
import 'package:app_bamk/presentation/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<bool> _isTokenValid() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: "jwt_token");
    print("Token: $token");

    if (token == null) return false;

    try {
      final parts = token.split(".");
      if (parts.length != 3) return false;

      final payload = json.decode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))),
      );

      /*await storage.write(key: "username", value: payload["username"]);*/

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
          return const DashboardPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
