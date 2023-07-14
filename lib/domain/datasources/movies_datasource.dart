import 'package:cinemapedia_app/domain/entities/movie.dart';

// Interfaz(datasource) que define los métodos que deben implementar los repositorios de películas
// Reglas de negocio
abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});
}
