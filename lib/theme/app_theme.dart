import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color palette
  static const Color bgDeep = Color(0xFF0A0E1A);
  static const Color bgCard = Color(0xFF1E2A3A);
  static const Color bgSurface = Color(0xFF0D1525);
  static const Color cyan = Color(0xFF00D4FF);
  static const Color green = Color(0xFF00FF88);
  static const Color purple = Color(0xFF7C3AED);
  static const Color amber = Color(0xFFFFB800);
  static const Color textPrimary = Color(0xFFE8F4FD);
  static const Color textMuted = Color(0xFF8899AA);
  static const Color borderColor = Color(0xFF1E3A5A);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgDeep,
      colorScheme: const ColorScheme.dark(
        primary: cyan,
        secondary: green,
        tertiary: purple,
        surface: bgCard,
        onSurface: textPrimary,
      ),
      textTheme: GoogleFonts.spaceGroteskTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w700,
            color: textPrimary,
            height: 1.1,
          ),
          displayMedium: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: textPrimary,
            height: 1.2,
          ),
          displaySmall: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          headlineSmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          titleLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: textPrimary,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: textMuted,
            height: 1.7,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: textMuted,
            height: 1.6,
          ),
          labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            color: cyan,
          ),
        ),
      ),
    );
  }
}
