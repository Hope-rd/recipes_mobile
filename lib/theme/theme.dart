import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
      primary: Colors.black, // temporary
      secondary: Color(0xFFFFFFFF),
      surface: Color(0xFFFFFFFF),
    ),

    scaffoldBackgroundColor: const Color(0xFFFFFFFF),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF1C1C1C),
      elevation: 0,
    ),

    cardTheme: CardThemeData(
      color: const Color.fromARGB(255, 245, 245, 245),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),

    dividerColor: const Color(0xFFE0E0E0),

    textTheme: GoogleFonts.poppinsTextTheme(
      TextTheme(
        bodyLarge: TextStyle(color: Color(0xFF1C1C1C), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFF36454F), fontSize: 10),
      bodySmall: TextStyle(color: Color(0xFF1C1C1C), fontWeight: FontWeight.w400),
      
      titleLarge: TextStyle(
        color: Color(0xFF282828),
        fontWeight: FontWeight.bold,
        fontSize: 15
      ),
      titleMedium: TextStyle(
        color: Color(0xFF1C1C1C),
        fontWeight: FontWeight.bold,
        fontSize: 20
      ),
      titleSmall: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),

      labelSmall: TextStyle(
        color: Color(0xFF1C1C1C),
        fontSize: 9,
        fontWeight: FontWeight.w500
      ),
      headlineSmall: TextStyle(
        color: Color(0xFF1C1C1C),
        fontSize: 15,
        fontWeight: FontWeight.bold
      )
      )
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

    cardTheme: CardThemeData(
      color: const Color(0xFF000000),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    dividerColor: const Color(0xFF2C2C2C),

    textTheme: GoogleFonts.poppinsTextTheme(
      TextTheme(
        bodyLarge: TextStyle(color: Color(0xFFEDEDED), fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFFA0A0A0), fontSize: 14),
      bodySmall: TextStyle(color: Color(0xFFEDEDED), fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
        color: Color(0xFFEDEDED),
        fontWeight: FontWeight.bold,
        fontSize: 22
      ),
      titleMedium: TextStyle(
        color: Color(0xFFEDEDED),
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
      titleSmall: TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      ),
      )
    ),

    iconTheme: const IconThemeData(
      color: Color(0xFFEDEDED),
    ),
  useMaterial3: true
);