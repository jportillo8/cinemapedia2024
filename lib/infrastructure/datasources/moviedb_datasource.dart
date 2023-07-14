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
      'language': 'en-MX',
    },
  ));
  // Implementación del método getNowPlaying
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // Petición GET a la API de The Movie DB
    final response = await dio.get('/movie/now_playing', queryParameters: {
      'page': page,
    });

    // Mapeo de la respuesta a una lista de objetos Movie y retorno de la lista
    final movieDBResponse = MovieDBResponse.fromJson(response.data);
    final List<Movie> movies = movieDBResponse.results
        .where((moviedb) => moviedb.posterPath != 'no-poster')
        .map((moviedb) => MovieMapper.movieDBEntity(moviedb))
        .toList();
    return movies;
  }
}
