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
}
