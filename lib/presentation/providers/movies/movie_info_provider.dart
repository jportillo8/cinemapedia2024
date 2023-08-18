import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieInfoProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final getMovie = ref.watch(movieRepositoryProvider).getMovieById;

  return MovieMapNotifier(getMapMovie: getMovie);
});

/*
    '501203' : Movie(),
    '531203' : Movie(),
    '551203' : Movie(),
*/

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMapMovie;

  MovieMapNotifier({required this.getMapMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;

    final movie = await getMapMovie(movieId);

    state = {
      ...state,
      movieId: movie,
    };
  }
}
