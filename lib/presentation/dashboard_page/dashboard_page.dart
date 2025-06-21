import 'package:app_bamk/presentation/dashboard_page/widgets/dashboard_page_form.dart';
import 'package:app_bamk/presentation/dashboard_page/widgets/dashboard_top10_page_form.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff000000),
        appBar: AppBar(
          backgroundColor: const Color(0xff1a1a1a), // Background for AppBar
          automaticallyImplyLeading: false, // Remove "Back-Button" from AppBar
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'assets/logo_bamk.png',
                height: 50,
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.bold,
                    )
                  ),
                ),
              ),
            ], // End of child
          ),
        ),
        body: DashboardTop10PageForm(),
    );
  }
}