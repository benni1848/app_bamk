import 'package:app_bamk/api/services/auth_service.dart';
import 'package:app_bamk/presentation/login_page/login_page.dart';
import 'package:app_bamk/presentation/userProfile_page/widgets/container_profilePicture.dart';
import 'package:app_bamk/presentation/userProfile_page/widgets/container_profileInformation.dart';
import 'package:flutter/material.dart';
import 'package:app_bamk/api/services/ticket_service.dart'; //Ticket-Service hinzugefügt

class UserprofileForm extends StatefulWidget {
  const UserprofileForm({super.key});

  @override
  State<UserprofileForm> createState() => _UserprofileFormState();
}

class _UserprofileFormState extends State<UserprofileForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(
        children: [
          ContainerProfilePicture(),
          ContainerProfileInformation(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 20),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(10),
                backgroundColor: Color(0xFFE97F80),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              onPressed: () async {
                final authService = AuthService(); // Lokale Instanz erstellen
                await authService.logout();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
