import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/movie_repository_impl.dart';

// Este repositorio es inmutable, por lo que se puede usar un provider normal
final movieRepositoryProvider = Provider((ref) {
  // Se retorna una instancia de MovieRepositoryImpl con una instancia de MoviedbDatasource
  // MoviedbDatasource es la fuente de datos de la API de --The Movie DB--
  return MovieRepositoryImpl(MoviedbDatasource());
});

// En conclusión, este provider envia una instancia de MovieRepositoryImpl a los widgets que lo consumen
// Enviando una lista de películas a los widgets que lo consumen
