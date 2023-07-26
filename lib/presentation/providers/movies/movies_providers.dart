import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';

/* Este provider es mutable, por lo que se usa un StateNotifierProvider
 Carga la primera página de películas
 Notifica a los listeners cuando se cargan más películas */
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final upcomingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getUpcoming;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final topRatedMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

// Es una función que recibe un entero y retorna un Future<List<Movie>>
typedef MovieCallback = Future<List<Movie>> Function({int page});

// Controler de estado para la lista de películas
// Se inyecta la función que carga las películas
class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  // Carga la primera página de películas
  // Se obtiene la lista de películas variando el número de página
  // Se añaden las películas a la lista de películas y se notifica a los listeners
  Future<void> loadNextPage() async {
    /* Impedir que se hagan varias peticiones */
    if (isLoading) return;
    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}

// En conclusión, este provider envia listas de películas a los widgets que lo consumen y 
//notifica a los listeners cuando se cargan más películas
