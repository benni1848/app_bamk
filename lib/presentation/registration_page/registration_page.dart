import 'package:app_bamk/presentation/registration_page/widgets/registration_page_form.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF1a1a1a),
      body: RegistrationPageForm(),
    );
  }
}
