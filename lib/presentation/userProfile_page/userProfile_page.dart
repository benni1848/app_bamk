import 'package:app_bamk/presentation/userProfile_page/widgets/userProfile_page_form.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BAMK"),
      ),
      backgroundColor: const Color(0xFF1a1a1a),
      body: const UserprofileForm(),
    ); // BottomNavigationBar einfügen (einlesen)
  }
}
