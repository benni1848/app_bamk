import 'package:app_bamk/presentation/login_page/widgets/login_page_form.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xFF1a1a1a), body: LoginPageForm());
  }
}
