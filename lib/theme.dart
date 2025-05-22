import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _lightPrimaryColor = Colors.white;
  static const Color _lightPrimaryVariantColor = Color.fromRGBO(187, 0, 0, 1);
  static const Color _lightOnPrimaryColor = Color.fromRGBO(187, 0, 0, 1);
  static const Color _lightTextColorPrimary = Colors.black;
  static const Color _appbarColorLight = Color.fromRGBO(187, 0, 0, 1);

  static const Color _iconColor = Colors.white;

  static const TextStyle _lightHeadingText =
      TextStyle(color: _lightTextColorPrimary, fontFamily: "Open Sans");

  static const TextStyle _lightBodyText =
      TextStyle(color: _lightTextColorPrimary, fontFamily: "Open Sans");

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightHeadingText,
    bodyLarge: _lightBodyText,
  );

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
          floatingLabelStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey)));

  static final ThemeData lightTheme = ThemeData(
      inputDecorationTheme: _inputDecorationTheme,
      scaffoldBackgroundColor: _lightPrimaryColor,
      appBarTheme: const AppBarTheme(
          color: _appbarColorLight,
          iconTheme: IconThemeData(color: _iconColor)),
      bottomAppBarTheme: const BottomAppBarTheme(color: _appbarColorLight),
      colorScheme: const ColorScheme.light(
          primary: _lightPrimaryColor,
          onPrimary: _lightOnPrimaryColor,
          primaryContainer: _lightPrimaryVariantColor),
      textTheme: _lightTextTheme);
}