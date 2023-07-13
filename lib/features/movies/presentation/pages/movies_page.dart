import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/features/movies/domain/models/movie_detail_args_model.dart';
import 'package:movies_app/features/movies/presentation/widgets/movies_carousel_slider.dart';
import 'package:movies_app/features/movies/presentation/widgets/movies_scrollview.dart';
import 'package:sizer/sizer.dart';
import 'package:skeletons/skeletons.dart';
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
    BlocProvider.of<MoviesBloc>(context).add(const GetMoviesEvent("Discover"));
    BlocProvider.of<MoviesBloc>(context)
        .add(const GetTopRatedMoviesEvent("Top Rated"));
    BlocProvider.of<MoviesBloc>(context)
        .add(const GetUpcomingMoviesEvent("Upcoming"));
    BlocProvider.of<MoviesBloc>(context)
        .add(const GetArabicMoviesEvent("Arabic"));
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
                buildWhen: (previous, current) => (current is TopRatedSuccess ||
                    current is TopRatedLoading ||
                    current is TopRatedError),
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
                buildWhen: (previous, current) => (current is UpcomingSuccess ||
                    current is UpcomingLoading ||
                    current is UpcomingError),
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
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) => (current is ArabicSuccess ||
                    current is ArabicLoading ||
                    current is ArabicError),
                key: UniqueKey(),
                builder: (context, state) {
                  if (state is ArabicSuccess) {
                    return MoviesScrollview(
                        // cacheManager: customCacheManager,
                        onMovieClick: onMovieClick,
                        movieList: state.movieList,
                        moviesType: "Arabic");
                  } else if (state is ArabicLoading) {
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
              Skeleton(
                  darkShimmerGradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 31, 31, 60),
                    Color.fromARGB(255, 17, 17, 40),
                  ]),
                  isLoading: true,
                  themeMode: ThemeMode.dark,
                  skeleton: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: colors.primaryDark,
                            borderRadius: BorderRadius.circular(12.sp)),
                        width: 90.sp,
                        height: 125.sp,
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: colors.primaryDark,
                            borderRadius: BorderRadius.circular(12.sp)),
                        width: 60.sp,
                        height: 10.sp,
                      ),
                      SizedBox(
                        height: 6.sp,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: colors.primaryDark,
                            borderRadius: BorderRadius.circular(12.sp)),
                        width: 25.sp,
                        height: 10.sp,
                      ),
                    ],
                  ),
                  child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
