import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MoviesSlideshow extends StatelessWidget {
  final List<Movie> movies;

  const MoviesSlideshow({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 210,
      child: Swiper(
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: colors.secondary,
          ),
        ),
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        itemCount: movies.length,
        itemBuilder: (context, index) => _Slide(movie: movies[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 20,
          offset: Offset(0, 10),
        ),
      ],
    );

    return GestureDetector(
      onTap: () => context.push('/home/0/movie/${movie.id}'),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.backdropPath,
              fit: BoxFit.cover,
              // Cuando la imagen se construye, se muestra el título de la película
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const DecoratedBox(
                      decoration: BoxDecoration(color: Colors.black12));
                }
                return FadeIn(child: child);
              },
            ),
          ),
        ),
      ),
    );
  }
}
