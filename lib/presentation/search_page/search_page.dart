import 'package:app_bamk/presentation/search_page/widgets/search_page_form.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
          backgroundColor: Color(0xFF1a1a1a), body: SearchPageForm());
  }
}