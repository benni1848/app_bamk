import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String hinttext;
  final Color textcolor;
  final Color fillcolor;
  final IconData icon;
  final bool hideText;
  final String? Function(String?)? validator;
  const CustomTextfield(
      {super.key,
      required this.hinttext,
      required this.textcolor,
      required this.fillcolor,
      required this.icon,
      required this.validator,
      required this.hideText});

  @override
  State<CustomTextfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: TextStyle(color: widget.textcolor),
        obscureText: widget.hideText,
        decoration: InputDecoration(
          hintText: widget.hinttext,
          filled: true,
          fillColor: widget.fillcolor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: Icon(widget.icon, color: Colors.black),
        ),
        validator: widget.validator);
  }
}
