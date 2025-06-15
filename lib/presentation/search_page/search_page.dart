//import 'package:app_bamk/presentation/search_page/widgets/search_page_form.dart';
import 'package:app_bamk/presentation/search_page/widgets/search_page_form.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final List<String>? initialSelectedGenres;

  const SearchPage({super.key, this.initialSelectedGenres});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000000),
      appBar: AppBar(
        backgroundColor: const Color(0xff1a1a1a),
        automaticallyImplyLeading: false,
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
                  style: TextStyle(
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SearchPageForm(initialSelectedGenres: initialSelectedGenres),
    );
  }
}
