import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/movies/movie_masonry.dart';

class PopularView extends ConsumerStatefulWidget {
  const PopularView({super.key});

  @override
  PopularViewState createState() => PopularViewState();
}

class PopularViewState extends ConsumerState<PopularView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final popularMovies = ref.watch(popularMoviesProvider);

    if (popularMovies.isEmpty) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return Scaffold(
      appBar: AppBar(
        elevation: popularMovies.isEmpty ? 0 : 4,
        title: const Text('Las más populares'),
      ),
      body: MovieMasonry(
          loadNextPage: () =>
              ref.read(popularMoviesProvider.notifier).loadNextPage(),
          movies: popularMovies),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
