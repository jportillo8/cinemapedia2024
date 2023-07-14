import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'movies_providers.dart';

// Este provider es mutable, por lo que se usa un StateNotifierProvider
// Es una combinación de los providers nowPlayingMoviesProvider y movieRepositoryProvider
// nowPlayingMoviesProvider es un StateNotifierProvider que retorna un MoviesNotifier
// movieRepositoryProvider es un Provider que retorna un MovieRepository
final moviesSlideshowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

  if (nowPlayingMovies.isEmpty) return [];
  // Se retorna una lista de 6 películas
  return nowPlayingMovies.sublist(0, 6);
});

// En conclusión, este provider envia listas de películas a los widgets que lo consumen