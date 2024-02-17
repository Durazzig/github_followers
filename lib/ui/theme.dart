import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
    foregroundColor: Colors.grey.shade900,
  ),
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.purple,
    secondary: Colors.grey.shade200,
  ),
  iconTheme: IconThemeData(
    color: Colors.grey.shade900,
  ),
  textTheme: const TextTheme(
    labelLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.green,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey.shade900,
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.grey.shade900,
    foregroundColor: Colors.white,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.grey.shade900,
  ),
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.white,
    secondary: Colors.grey.shade800,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  textTheme: const TextTheme(
    labelLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(
      color: Colors.white,
    ),
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Colors.green,
  ),
);
