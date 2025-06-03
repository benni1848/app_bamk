import 'package:app_bamk/presentation/dashboard_page/widgets/dashboard_page_form.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Color(0xFF1a1a1a), body: DashboardPageForm());
  }
}