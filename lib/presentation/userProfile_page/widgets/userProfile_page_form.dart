import 'package:app_bamk/api/services/auth_service.dart';
import 'package:app_bamk/presentation/login_page/login_page.dart';
import 'package:app_bamk/presentation/userProfile_page/widgets/container_profilePicture.dart';
import 'package:app_bamk/presentation/userProfile_page/widgets/container_profileInformation.dart';
import 'package:flutter/material.dart';

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
          TextButton(
            child: Text("Logout"),
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
          ContainerProfileInformation(),
        ],
      ),
    );
  }
}
