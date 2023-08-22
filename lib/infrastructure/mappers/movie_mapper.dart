import 'package:cinemapedia_app/infrastructure/models/moviedb/movie_details.dart';

import '../../domain/entities/movie.dart';
import '../models/moviedb/movie_moviedb.dart';

class MovieMapper {
// Toma la respuesta de la API y la convierte en una entidad de dominio

  static Movie movieDBEntity(MovieMovieDB moviedb) => Movie(
        adult: moviedb.adult,
        backdropPath: moviedb.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}'
            : 'https://cdn.pixabay.com/photo/2016/11/16/11/29/coupon-1828620_1280.png',
        genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
        id: moviedb.id,
        originalLanguage: moviedb.originalLanguage,
        originalTitle: moviedb.originalTitle,
        overview: moviedb.overview,
        popularity: moviedb.popularity,
        posterPath: moviedb.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}'
            : 'no-poster',
        releaseDate:
            moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime(0),
        title: moviedb.title,
        video: moviedb.video,
        voteAverage: moviedb.voteAverage,
        voteCount: moviedb.voteCount,
      );

  static movieDetailsToEntity(MovieDetails movie) => Movie(
        adult: movie.adult,
        backdropPath: movie.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${movie.backdropPath}'
            : 'https://cdn.pixabay.com/photo/2016/11/16/11/29/coupon-1828620_1280.png',
        genreIds: movie.genres.map((e) => e.name).toList(),
        id: movie.id,
        originalLanguage: movie.originalLanguage,
        originalTitle: movie.originalTitle,
        overview: movie.overview,
        popularity: movie.popularity,
        posterPath: movie.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500/${movie.posterPath}'
            : 'no-poster',
        releaseDate: movie.releaseDate,
        title: movie.title,
        video: movie.video,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
      );
}
