import 'package:cinemapedia_app/infrastructure/datasources/moviedb_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/repositories/movie_repository_impl.dart';

// Este repositorio es inmutable, por lo que se puede usar un provider normal
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(MoviedbDatasource());
});
