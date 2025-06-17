import 'package:app_bamk/api/services/auth_service.dart';
import 'package:app_bamk/presentation/dashboard_page/widgets/container_topTenMovie.dart';
import 'package:app_bamk/presentation/dashboard_page/widgets/container_topTenMusic.dart';
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
        child: ListView(children: [
      // Container for Top 10
      ContainerTopTenMovie(),
      ContainerTopTenMusic(),

      // Logout Button am Ende
    ]));
  }
}
