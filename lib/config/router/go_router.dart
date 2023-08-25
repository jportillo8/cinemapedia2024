import 'package:cinemapedia_app/presentation/screen/screens.dart';
import 'package:go_router/go_router.dart';

// Rutas de la aplicación
final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
      path: '/home/:page',
      name: HomeScreen.routeName,
      builder: (context, state) {
        final pageIndex = int.parse(state.pathParameters['page'] ?? '0');
        return HomeScreen(pageIndex: pageIndex);
      },
      routes: [
        GoRoute(
          path: 'movie/:id',
          name: MovieScreen.routeName,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? '';
            return MovieScreen(movieId: movieId);
          },
        )
      ],
    ),
    GoRoute(path: '/', redirect: (_, __) => '/home/0')
  ],
);
