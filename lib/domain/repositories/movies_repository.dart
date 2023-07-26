import 'package:cinemapedia_app/domain/entities/movie.dart';

// Interfaz(repositorio) que define los métodos que deben implementar los repositorios de películas
// Reglas de negocio
abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
}
