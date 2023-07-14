import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigationbar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMoviesState = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.only(bottom: 10),
            title: CustomAppbar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Column(
                children: [
                  // const CustomAppbar(),
                  MoviesSlideshow(movies: slideShowMovies),
                  MovieHorizontalListview(
                      loadNextPage: () {
                        ref
                            .read(nowPlayingMoviesProvider.notifier)
                            .loadNextPage();
                      },
                      movies: nowPlayingMoviesState,
                      title: 'En cines',
                      subtitle: 'Lunes 20'),
                  MovieHorizontalListview(
                      loadNextPage: () {
                        ref
                            .read(nowPlayingMoviesProvider.notifier)
                            .loadNextPage();
                      },
                      movies: nowPlayingMoviesState,
                      title: 'En cines',
                      subtitle: 'Lunes 20'),
                  SizedBox(height: 20)
                ],
              );
            },
            childCount: 1,
          ),
        )
      ],
    );
  }
}
