import 'package:app_bamk/domain/entities/game_entity.dart';
import 'package:app_bamk/presentation/game_page/widgets/game_page_form.dart';
import 'package:flutter/material.dart';

class GamePage extends StatelessWidget {
  final GameEntity game;
  const GamePage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1a1a1a),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF80B5E9),
        title: Text("Gameübersicht"),
      ),
      body: GamePageForm(
        game: game,
        username: '',
      ),
    );
  }
}
