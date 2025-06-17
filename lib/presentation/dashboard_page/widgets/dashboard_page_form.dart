import 'package:app_bamk/presentation/dashboard_page/widgets/container_TopTenMovie.dart';
import 'package:app_bamk/presentation/dashboard_page/widgets/container_topTenMusic.dart';
import 'package:flutter/material.dart';

class DashboardPageForm extends StatefulWidget {
  const DashboardPageForm({super.key});

  @override
  State<DashboardPageForm> createState() => _DashboardPageFormState();
}

class _DashboardPageFormState extends State<DashboardPageForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Hintergrund des Bodys
      body: Column(
        children: [
          ContainerTopTenMovie(),
          ContainerTopTenMusic(),
        ],
      ),
    );
  }
}