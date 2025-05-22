import 'package:app_bamk/presentation/userProfile_page/widgets/userProfile_page_form.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Color(0xFF1a1a1a),body: UserprofileForm(),); // BottomNavigationBar einfügen (einlesen)
  }
}