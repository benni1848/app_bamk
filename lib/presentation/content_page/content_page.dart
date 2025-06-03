import 'package:app_bamk/presentation/content_page/widgets/content_page_form.dart';
import 'package:flutter/material.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Color(0xFF1a1a1a),body: ContentPageForm());
  }
}