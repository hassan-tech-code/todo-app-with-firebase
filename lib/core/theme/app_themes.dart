import 'package:flutter/material.dart';

class AppTheme {
  ///Lighttheme

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
    cardTheme: CardThemeData(color: Colors.grey.shade300),
  );

  /// Dark Theme

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.blue,
    ),

    //drawerTheme: DrawerThemeData(backgroundColor: Colors.black),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.black,
    ),

    useMaterial3: true,
    cardTheme: CardThemeData(color: Colors.grey.shade800),
  );
}
