import 'package:app_bamk/domain/entities/music_entity.dart';
import 'package:app_bamk/presentation/music_page/widgets/music_page_form.dart';
import 'package:flutter/material.dart';

class MusicPage extends StatelessWidget {
  final MusicEntity music;
  const MusicPage({super.key, required this.music});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a1a),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF80B5E9),
        title: Text("Musikübersicht"),
      ),
      body: MusicPageForm(music: music),
    );
  }
}
