import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/config/helpers/human_formats.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListview extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subtitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({
    super.key,
    required this.movies,
    this.title,
    this.subtitle,
    this.loadNextPage,
  });

  @override
  State<MovieHorizontalListview> createState() =>
      _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {
  /* Parte dinamica de este widget */
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels + 200;
      if (currentScroll >= maxScroll) widget.loadNextPage!();
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  /* -.-.-.-.-.-.- */

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null || widget.subtitle != null)
            _Title(title: widget.title, subtitle: widget.subtitle),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, int index) =>
                  FadeInRightBig(child: _Slide(movie: widget.movies[index])),
            ),
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subtitle;

  const _Title({this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final subtitleStyle = Theme.of(context).textTheme.titleMedium;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(children: [
        if (title != null) Text(title!, style: titleStyle),
        const Spacer(),
        if (subtitle != null)
          FilledButton.tonal(
            style: const ButtonStyle(visualDensity: VisualDensity.compact),
            onPressed: () {},
            child: Text(subtitle!, style: subtitleStyle),
          )
      ]),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /* Imagen */
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  width: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      movie.posterPath,
                      height: 200,
                      width: 150,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress != null) {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                                heightFactor: 5,
                                child: CircularProgressIndicator()),
                          );
                        }
                        return GestureDetector(
                            onTap: () =>
                                context.push('/home/0/movie/${movie.id}'),
                            child: FadeIn(child: child));
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: _VoteAverage(movie: movie),
              ),
            ],
          ),
          /* Titulo */
          SizedBox(
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: textStyle.titleSmall,
            ),
          ),
          /* Rating */
          SizedBox(
            width: 150,
            child: Row(
              children: [
                Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
                const SizedBox(width: 3),
                Text(
                  movie.voteAverage.toString(),
                  style: textStyle.bodyMedium
                      ?.copyWith(color: Colors.yellow.shade800),
                ),
                const Spacer(),
                Text(
                  HumanFormats.number(movie.popularity),
                  style: textStyle.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VoteAverage extends StatelessWidget {
  final Movie movie;
  const _VoteAverage({
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    final style =
        Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white);
    final boxDecoration = BoxDecoration(
      color: Colors.black.withOpacity(0.7),
      borderRadius: BorderRadius.circular(50),
    );
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: boxDecoration,
      child: Stack(
        children: [
          CircularProgressIndicator(
            value: movie.voteAverage / 10,
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(movie.voteAverage > 7
                ? Colors.green
                : movie.voteAverage > 5
                    ? Colors.yellow
                    : Colors.red),
            color: Colors.black,
            backgroundColor: Colors.black.withOpacity(0.4),
          ),
          Positioned(
            top: 8,
            left: 6,
            child: Text(
              '${HumanFormats.percentage(movie.voteAverage)}%',
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
