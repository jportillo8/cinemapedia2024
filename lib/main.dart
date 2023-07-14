import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinemapedia_app/config/router/go_router.dart';

import 'package:cinemapedia_app/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  // Cargar variables de entorno
  await dotenv.load(fileName: '.env');
  // ProviderScope para usar Riverpod
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // Rutas definidas en go_router.dart
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      // Tema de la app
      theme: AppTheme().getTheme(),
    );
  }
}
