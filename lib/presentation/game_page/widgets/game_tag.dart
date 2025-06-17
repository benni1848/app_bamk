import 'package:flutter/material.dart';

class GameTag extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const GameTag({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF80B5E9),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
