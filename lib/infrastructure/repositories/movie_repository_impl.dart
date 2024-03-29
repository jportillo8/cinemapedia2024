import 'package:cinemapedia_app/domain/entities/video.dart';
import 'package:cinemapedia_app/domain/repositories/movies_repository.dart';

import 'package:cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';

// Clase que implementa la interfaz MoviesRepository
class MovieRepositoryImpl extends MoviesRepository {
  final MoviesDataSource dataSource;

  MovieRepositoryImpl(this.dataSource);

  // Implementación del método getNowPlaying
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return dataSource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return dataSource.getUpcoming(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return dataSource.getTopRated(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) {
    return dataSource.getMovieById(id);
  }

  @override
  Future<List<Movie>> searchMovies(String query) {
    return dataSource.searchMovies(query);
  }

  @override
  Future<List<Video>> getYoutubeVideosById(int movieId) {
    return dataSource.getYoutubeVideosById(movieId);
  }

  @override
  Future<List<Movie>> getSimilarMovies(int movieId) {
    return dataSource.getSimilarMovies(movieId);
  }
}
