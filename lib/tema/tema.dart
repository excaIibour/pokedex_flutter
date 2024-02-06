import 'package:flutter/material.dart';

class Tema {
  static ColorScheme cores = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF5E5E7B),
    onPrimary: Color(0xFF242A00),
    primaryContainer: Color(0xFF414C00),
    onPrimaryContainer: Color(0xFFA8C004),
    secondary: Color(0xFF303154),
    onSecondary: Color(0xFF2D331C),
    secondaryContainer: Color(0xFF434931),
    onSecondaryContainer: Color.fromARGB(255, 86, 105, 12),
    tertiary: Color(0xFFF6FBFB),
    onTertiary: Color(0xFF3A1B75),
    tertiaryContainer: Color(0xFF51358D),
    onTertiaryContainer: Color.fromARGB(255, 103, 41, 208),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFFF6FBFB),
    onBackground: Color(0xFFF6FBFB),
    surface: Color(0xFFF6FBFB),
    onSurface: Color(0xFF303154),
    surfaceVariant: Color(0xFF46483B),
    onSurfaceVariant: Color(0xFFE5E2DA),
    outline: Color(0xFF919283),
    inverseSurface: Color(0xFFE5E2DA),
    onInverseSurface: Color(0xFF1C1C17),
    inversePrimary: Color(0xFF576500),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFF247979),
    outlineVariant: Color(0xFF46483B),
    scrim: Color(0xFF000000),
  );

  static ThemeData tema = ThemeData(
    useMaterial3: true,
    colorScheme: cores,
    fontFamily: 'Blinker',
    textTheme: const TextTheme(
      labelLarge: TextStyle(fontWeight: FontWeight.w800),
    ),
  );
}