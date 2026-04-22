import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
      primary: Colors.black, // temporary
      secondary: Colors.white,
      surface: Color(0xFFFFFFFF),
    ),

    scaffoldBackgroundColor: const Color(0xFFFFFFFF),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF1C1C1C),
      elevation: 0,
    ),

    /*cardTheme: CardThemeData(
      color: const Color(0xFFFFFFFF),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),*/

    dividerColor: const Color(0xFFE0E0E0),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1C1C1C)),
      bodyMedium: TextStyle(color: Color(0xFF6B6B6B)),
      bodySmall: TextStyle(color: Color(0xFF1C1C1C), fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
        color: Color(0xFF1C1C1C),
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Color(0xFF1C1C1C),
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
    ),

    iconTheme: const IconThemeData(
      color: Color(0xFF1C1C1C),
    ),
  useMaterial3: true
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
      primary: Colors.white, // temporary
      secondary: Colors.white,
      surface: Color(0xFF000000),
    ),

    scaffoldBackgroundColor: const Color(0xFF121212),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Color(0xFFEDEDED),
      elevation: 0,
    ),

    /*cardTheme: CardThemeData(
      color: const Color(0xFF000000),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),*/

    dividerColor: const Color(0xFF2C2C2C),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFEDEDED)),
      bodyMedium: TextStyle(color: Color(0xFFA0A0A0)),
      bodySmall: TextStyle(color: Color(0xFFEDEDED), fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
        color: Color(0xFFEDEDED),
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Color(0xFFEDEDED),
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
    ),

    iconTheme: const IconThemeData(
      color: Color(0xFFEDEDED),
    ),
  useMaterial3: true
);