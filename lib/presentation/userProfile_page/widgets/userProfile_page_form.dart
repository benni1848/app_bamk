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
    return Scaffold(
      backgroundColor: Colors.black, // Hintergrund des Bodys
      body: Column(
        children: [
          ContainerProfilePicture(),
          ContainerProfileInformation(),
        ],
      ),
    );
  }
}
