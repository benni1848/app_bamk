import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String hinttext;
  final IconData icon;
  final bool hideText;
  final String? Function(String?)? validator;
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hinttext,
    required this.icon,
    required this.validator,
    required this.hideText,
  });

  @override
  State<CustomTextfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        style: const TextStyle(color: Color(0xff3f4b3b)),
        obscureText: widget.hideText,
        decoration: InputDecoration(
          hintText: widget.hinttext,
          filled: true,
          fillColor: const Color(0xFFd9d9d9),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(widget.icon, color: Colors.black),
        ),
        validator: widget.validator);
  }
}
