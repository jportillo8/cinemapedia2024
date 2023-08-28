import 'package:flutter/material.dart';

// Configuración del tema de la aplicación
class AppTheme {
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.white,
      brightness: Brightness.dark);
}
