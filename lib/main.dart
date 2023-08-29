import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinemapedia_app/config/router/go_router.dart';

import 'package:cinemapedia_app/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  // Inicializar date formats
  initializeDateFormatting('es_ES', null);
  // Cargar variables de entorno
  await dotenv.load(fileName: '.env');
  // ProviderScope para usar Riverpod
  runApp(const ProviderScope(child: MainApp()));
  await Future.delayed(const Duration(milliseconds: 100));
  FlutterNativeSplash.remove();
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
