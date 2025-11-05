import 'package:flutter/material.dart';

class AppTheme {
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2CE48B), Color(0xFF0A8ED9)],
  );
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 57, 175, 244),
      Color.fromARGB(255, 74, 255, 168),
    ],
  );
  static const Color primaryColor = Color.fromARGB(255, 2, 179, 93);
  static const Color secondaryColor = Color(0xFF0A8ED9);
  static const Color cardBackgroundColor = Colors.white;
}
