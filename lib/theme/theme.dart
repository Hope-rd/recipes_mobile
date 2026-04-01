import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    surface: Colors.white,
    primary: Colors.deepPurple,           // Better primary color (change as you like)
    onPrimary: Colors.white,
    secondary: Colors.grey.shade300,
    onSecondary: Colors.black,
    onBackground: Colors.black,
    onSurface: Colors.black,
  ),
  useMaterial3: true
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    surface: Colors.grey.shade900,   // Slightly lighter than pure black for better UX
    primary: Colors.deepPurple,            // Keep same primary or change
    onPrimary: Colors.white,
    secondary: Colors.grey.shade800,
    onSecondary: Colors.white,
    onBackground: Colors.white,
    onSurface: Colors.white,
  ),
  useMaterial3: true
);