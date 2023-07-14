import 'package:cinemapedia_app/presentation/screen/screens.dart';
import 'package:go_router/go_router.dart';

// Rutas de la aplicación
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    )
  ],
);
