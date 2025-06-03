import 'package:app_bamk/presentation/film_page/widgets/film_page_form.dart';
import 'package:flutter/material.dart';

class FilmPage extends StatelessWidget {
  const FilmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a1a),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF80B5E9),
        title: const Text("Filmübersicht"),
      ),
      body: const FilmPageForm(),
    );
  }
}
