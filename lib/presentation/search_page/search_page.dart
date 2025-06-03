//import 'package:app_bamk/presentation/search_page/widgets/search_page_form.dart';
import 'package:app_bamk/presentation/search_page/widgets/search_page_form.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff2c2f33),
        appBar: AppBar(
          backgroundColor: const Color(0xFF80B5E9), // Background for AppBar
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
                    'Inhalte durchsuchen',
                  ),
                ),
              ),
            ], // End of child
          ),
        ),
        body: SearchPageForm());
  }
}
