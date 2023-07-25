import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/domain/models/more_movies_args_model.dart';
import 'package:movies_app/features/movies/domain/models/movie_detail_args_model.dart';
import 'package:movies_app/features/movies/presentation/widgets/movies_carousel_slider.dart';
import 'package:movies_app/features/movies/presentation/widgets/movies_scrollview.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../../utils/pages.dart' as pages;
import '../bloc/movies_bloc.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  void initState() {
    BlocProvider.of<MoviesBloc>(context)
        .add(const GetMoviesEvent("Discover", 1));
    BlocProvider.of<MoviesBloc>(context)
        .add(const GetTopRatedMoviesEvent("Top Rated", 1));
    BlocProvider.of<MoviesBloc>(context)
        .add(const GetUpcomingMoviesEvent("Upcoming", 1));
    BlocProvider.of<MoviesBloc>(context)
        .add(const GetArabicMoviesEvent("Arabic", 1));
    super.initState();
  }

  void onMovieClick(MovieDetailArgs movieDetailArgs) {
    Navigator.pushNamed(context, pages.movieDetailPage,
        arguments: movieDetailArgs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.primaryDark,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) => (current is MoviesSuccess ||
                    current is MoviesLoading ||
                    current is MoviesError),
                builder: (context, state) {
                  if (state is MoviesSuccess) {
                    return MoviesCarouselSlider(
                      movieList: state.movieList,
                      onMovieClick: onMovieClick,
                      onMoreClick: () {
                        final args =
                            MoreMoviesArgs('Discover', state.movieList);
                        Navigator.pushNamed(context, pages.moreMoviesPage,
                            arguments: args);
                      },
                    );
                  } else if (state is MoviesLoading) {
                    return Container();
                  } else if (state is MoviesError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) => (current is TopRatedSuccess ||
                    current is TopRatedLoading ||
                    current is TopRatedError),
                key: UniqueKey(),
                builder: (context, state) {
                  if (state is TopRatedSuccess) {
                    return MoviesScrollview(
                        isLoading: false,
                        hasMore: true,
                        onMoreClick: () {
                          final args =
                              MoreMoviesArgs('Top Rated', state.movieList);
                          Navigator.pushNamed(context, pages.moreMoviesPage,
                              arguments: args);
                        },
                        onMovieClick: onMovieClick,
                        movieList: state.movieList,
                        moviesType: "Top Rated");
                  } else if (state is TopRatedLoading) {
                    return MoviesScrollview(
                        isLoading: true,
                        hasMore: true,
                        onMoreClick: () {},
                        onMovieClick: () {},
                        movieList: const [],
                        moviesType: "Top Rated");
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) => (current is UpcomingSuccess ||
                    current is UpcomingLoading ||
                    current is UpcomingError),
                key: UniqueKey(),
                builder: (context, state) {
                  if (state is UpcomingSuccess) {
                    return MoviesScrollview(
                        isLoading: false,
                        hasMore: true,
                        onMoreClick: () {
                          final args =
                              MoreMoviesArgs('Upcoming', state.movieList);
                          Navigator.pushNamed(context, pages.moreMoviesPage,
                              arguments: args);
                        },
                        onMovieClick: onMovieClick,
                        movieList: state.movieList,
                        moviesType: "Upcoming");
                  } else if (state is UpcomingLoading) {
                    return MoviesScrollview(
                        isLoading: true,
                        hasMore: true,
                        onMoreClick: () {},
                        onMovieClick: () {},
                        movieList: const [],
                        moviesType: "Upcoming");
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) => (current is ArabicSuccess ||
                    current is ArabicLoading ||
                    current is ArabicError),
                key: UniqueKey(),
                builder: (context, state) {
                  if (state is ArabicSuccess) {
                    return MoviesScrollview(
                        isLoading: false,
                        hasMore: true,
                        onMoreClick: () {
                          final args =
                              MoreMoviesArgs('Arabic', state.movieList);
                          Navigator.pushNamed(context, pages.moreMoviesPage,
                              arguments: args);
                        },
                        onMovieClick: onMovieClick,
                        movieList: state.movieList,
                        moviesType: "Arabic");
                  } else if (state is ArabicLoading) {
                    return MoviesScrollview(
                        isLoading: true,
                        hasMore: true,
                        onMoreClick: () {},
                        onMovieClick: () {},
                        movieList: const [],
                        moviesType: "Arabic");
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
