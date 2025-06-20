import 'package:flutter/material.dart';

class AppTheme {
  // Primary Colors
  static const Color primaryColor = Color(0xFF4CAF50); // Green
  static const Color secondaryColor = Color(0xFF2196F3); // Blue

  // Button Colors
  static const Color buttonColor = Color(0xFF4CAF50); // Green
  static const Color buttonTextColor = Colors.white;
  static const Color buttonDisabledColor = Color(0xFFBDBDBD); // Grey

  // Icon Colors
  static const Color iconColor = Color(0xFF4CAF50); // Green
  static const Color iconDisabledColor = Color(0xFFBDBDBD); // Grey

  // Text Colors
  static const Color textPrimaryColor = Color(0xFF212121); // Dark Grey
  static const Color textSecondaryColor = Color(0xFF757575); // Medium Grey

  // Background Colors
  static const Color backgroundColor = Colors.white;
  static const Color cardBackgroundColor = Colors.white;

  // Error Colors
  static const Color errorColor = Color(0xFFD32F2F); // Red

  // Success Colors
  static const Color successColor = Color(0xFF388E3C); // Dark Green

  // Border Colors
  static const Color borderColor = Color(0xFFE0E0E0); // Light Grey

  // Theme Data
  static ThemeData get theme => ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundColor,
      elevation: 0,
      iconTheme: IconThemeData(color: iconColor),
      titleTextStyle: TextStyle(
        color: textPrimaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: buttonTextColor,
        disabledBackgroundColor: buttonDisabledColor,
        disabledForegroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    iconTheme: const IconThemeData(color: iconColor),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: textPrimaryColor),
      bodyMedium: TextStyle(color: textPrimaryColor),
      titleLarge: TextStyle(color: textPrimaryColor),
    ),
    cardTheme: CardTheme(
      color: cardBackgroundColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
