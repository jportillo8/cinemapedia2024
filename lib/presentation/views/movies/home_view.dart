import 'package:cinemapedia_app/config/helpers/human_formats.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // Initial Loading
    final initialLoading = ref.watch(initialLoandingProvider);
    if (initialLoading) return FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    // Provider Movies
    final nowPlayingMoviesState = ref.watch(nowPlayingMoviesProvider);
    // final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    // Human Formats
    final dateNow = HumanFormats.date(DateTime.now().toString());
    // Invisible when initialLoading is true
    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(
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
                        title: 'En Cines',
                        subtitle: dateNow),
                    // MovieHorizontalListview(
                    //   loadNextPage: () {
                    //     ref.read(popularMoviesProvider.notifier).loadNextPage();
                    //   },
                    //   movies: popularMovies,
                    //   title: 'Más Populares',
                    // ),
                    MovieHorizontalListview(
                        loadNextPage: () {
                          ref
                              .read(upcomingMoviesProvider.notifier)
                              .loadNextPage();
                        },
                        movies: upcomingMovies,
                        title: 'Próximamente',
                        subtitle: 'Estrenos'),
                    MovieHorizontalListview(
                        loadNextPage: () {
                          ref
                              .read(topRatedMoviesProvider.notifier)
                              .loadNextPage();
                        },
                        movies: topRatedMovies,
                        title: 'Mejor Valoradas',
                        subtitle: 'Top Rated'),
                    const SizedBox(height: 10)
                  ],
                );
              },
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}
