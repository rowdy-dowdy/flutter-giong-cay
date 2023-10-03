// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ThemeModel {
  final ThemeMode themeMode;
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  ThemeModel({
    required this.lightTheme,
    required this.darkTheme,
    required this.themeMode
  });

  ThemeModel toggleTheme (ThemeMode themeMode) {
    return ThemeModel(lightTheme: lightTheme, darkTheme: darkTheme, themeMode: themeMode);
  }
}
