import 'package:app_bamk/api/services/auth_service.dart';
import 'package:app_bamk/presentation/login_page/login_page.dart';
import 'package:flutter/material.dart';

class DashboardPageForm extends StatefulWidget {
  const DashboardPageForm({super.key});

  @override
  State<DashboardPageForm> createState() => _DashboardPageFormState();
}

class _DashboardPageFormState extends State<DashboardPageForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Logout',
      onPressed: () async {
        final authService = AuthService(); // <-- Lokale Instanz erstellen
        await authService.logout();

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
        );
      },
    ));
  }
}
