import 'package:flutter/material.dart';

// Configuración del tema de la aplicación
class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2862F5),
      );
}
