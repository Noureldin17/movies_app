import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movies_app/features/movies/domain/models/movie_detail_args_model.dart';
import 'package:movies_app/features/movies/presentation/widgets/movies_carousel_slider.dart';
import 'package:movies_app/features/movies/presentation/widgets/movies_scrollview.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/api/tmdb_api_constants.dart';
import '../../../../utils/colors.dart' as colors;
// import 'package:google_fonts/google_fonts.dart';
import '../../../../utils/pages.dart' as pages;
// import 'package:flutter/src/widgets/framework.dart';

// import '../../../../utils/default_text.dart';
// import '../../../authentication/presentation/bloc/authentication_bloc.dart';
import '../../domain/models/movie_model.dart';
import '../bloc/movies_bloc.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  static final customCacheManager = CacheManager(Config('Movies_Cache_Manager',
      stalePeriod: const Duration(hours: 5), maxNrOfCacheObjects: 100));
  @override
  void initState() {
    BlocProvider.of<MoviesBloc>(context).add(const GetMoviesEvent("Discover"));
    BlocProvider.of<MoviesBloc>(context)
        .add(const GetTopRatedMoviesEvent("Top Rated"));
    BlocProvider.of<MoviesBloc>(context)
        .add(const GetUpcomingMoviesEvent("Upcoming"));
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
                buildWhen: (previous, current) =>
                    current is MoviesSuccess ||
                    current is MoviesLoading ||
                    current is MoviesError,
                builder: (context, state) {
                  if (state is MoviesSuccess) {
                    return MoviesCarouselSlider(
                      // cacheManager: customCacheManager,
                      movieList: state.movieList,
                      onMovieClick: onMovieClick,
                    );
                  } else if (state is MoviesLoading) {
                    return Container(
                        // color: colors.primaryGrey,
                        // height: 230.sp,
                        // width: 100.w,
                        // child: const Center(
                        //   child: CircularProgressIndicator(),
                        // ),
                        );
                  } else if (state is MoviesError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) =>
                    current is TopRatedSuccess ||
                    current is TopRatedLoading ||
                    current is TopRatedError,
                key: UniqueKey(),
                builder: (context, state) {
                  if (state is TopRatedSuccess) {
                    return MoviesScrollview(
                        // cacheManager: customCacheManager,
                        onMovieClick: onMovieClick,
                        movieList: state.movieList,
                        moviesType: "Top Rated");
                  } else if (state is TopRatedLoading) {
                    return Container(
                      height: 125.sp,
                      width: 90.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.sp)),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) =>
                    current is UpcomingSuccess ||
                    current is UpcomingLoading ||
                    current is UpcomingError,
                key: UniqueKey(),
                builder: (context, state) {
                  if (state is UpcomingSuccess) {
                    return MoviesScrollview(
                        // cacheManager: customCacheManager,
                        onMovieClick: onMovieClick,
                        movieList: state.movieList,
                        moviesType: "Upcoming");
                  } else if (state is UpcomingLoading) {
                    return Container(
                      height: 125.sp,
                      width: 90.sp,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.sp)),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
