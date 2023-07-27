import 'package:dio/dio.dart';

import 'package:cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/mappers/movie_mapper.dart';

import 'package:cinemapedia_app/infrastructure/models/moviedb/moviedb_response.dart';

// Clase que implementa la interfaz MoviesDataSource
class MoviedbDatasource extends MoviesDataSource {
  // Base url The Movie DB
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': 'ca4f8fb2912abdfc5f99a2fbde92ffa2',
      'language': 'es-MX',
    },
  ));

  // Mapeo de la respuesta a una lista de objetos Movie y retorno de la lista
  List<Movie> _jsonToMovieList(Map<String, dynamic> json) {
    final movieDBResponse = MovieDBResponse.fromJson(json);
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBEntity(moviedb))
        .toList();
    movies.removeWhere((movie) => movie.posterPath == 'no-poster');
    return movies;
  }

  // Organización de la lista de películas por fecha de lanzamiento
  List<Movie> _sortMoviesByDate(List<Movie> movies) {
    movies.sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
    return movies;
  }

  // Organización de la lista de películas por popularidad
  List<Movie> _sortMoviesByPopularity(List<Movie> movies) {
    movies.sort((a, b) => b.popularity.compareTo(a.popularity));
    return movies;
  }

  // Remover las peliculas con fecha de lanzamiento menor a 5 años
  List<Movie> _removeMoviesByAge(List<Movie> movies) {
    final ageActual = DateTime.now().year - 5;
    // Gurda la lista de peliculas sin quitar las peliculas
    List<Movie> listWithoutRemovingMovies = [];
    listWithoutRemovingMovies.addAll(movies);
    movies.removeWhere((movie) => movie.releaseDate.year < ageActual);

    if (movies.length < 3) {
      listWithoutRemovingMovies
          .sort((a, b) => b.releaseDate.compareTo(a.releaseDate));
      return listWithoutRemovingMovies.sublist(0, 3);
    } else {
      return movies;
    }
  }

// -----------------------------------------------------------------------------
  // Implementación del método getNowPlaying
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });
    final List<Movie> movies = _jsonToMovieList(response.data);
    return _sortMoviesByDate(movies);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response = await dio.get('/movie/popular', queryParameters: {
      'page': page,
    });
    final List<Movie> movies = _jsonToMovieList(response.data);
    return _sortMoviesByPopularity(movies);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', queryParameters: {
      'page': page,
    });
    final List<Movie> movies = _jsonToMovieList(response.data);
    return _sortMoviesByDate(movies);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', queryParameters: {
      'page': page,
    });
    final List<Movie> movies = _jsonToMovieList(response.data);
    return _removeMoviesByAge(movies);
  }
}
