import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:movies_app/features/movies/presentation/pages/sliver_app_bar_page.dart';
import 'package:movies_app/features/movies/presentation/widgets/movie_casts_view.dart';
import 'package:movies_app/features/movies/presentation/widgets/movie_info.dart';
import 'package:movies_app/features/movies/presentation/widgets/movies_scrollview.dart';
import 'package:movies_app/features/movies/presentation/widgets/pod_video_player.dart';
import '../../../../utils/pages.dart' as pages;
import '../../domain/models/movie_detail_args_model.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movieDetailArgs});
  final MovieDetailArgs movieDetailArgs;
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool isButtonVisible = true;
  bool isVideoVisible = true;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    BlocProvider.of<MoviesBloc>(context)
        .add(GetDetailsEvent(widget.movieDetailArgs.movie.movieId));
    BlocProvider.of<MoviesBloc>(context)
        .add(GetCreditsEvent(widget.movieDetailArgs.movie.movieId));
    BlocProvider.of<MoviesBloc>(context)
        .add(GetRecommendationsEvent(widget.movieDetailArgs.movie.movieId));
    super.initState();
  }

  void onMovieClick(MovieDetailArgs movieDetailArgs) {
    Navigator.pushNamed(context, pages.movieDetailPage,
        arguments: movieDetailArgs);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBarPage(
      movieDetailArgs: widget.movieDetailArgs,
      body: SliverToBoxAdapter(
        child: Container(
          child: Column(
            children: [
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) =>
                    current is DetailsSuccess ||
                    current is DetailsError ||
                    current is DetailsLoading,
                builder: (context, state) {
                  if (state is DetailsSuccess) {
                    return MovieInfo(
                      movieDetails: state.movieDetails,
                      movie: widget.movieDetailArgs.movie,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) =>
                    current is CreditsSuccess ||
                    current is CreditsLoading ||
                    current is CreditsError,
                builder: (context, state) {
                  if (state is CreditsSuccess) {
                    return MovieCastsView(
                      cast: state.castsList,
                    );
                  } else if (state is CreditsLoading) {
                    return Container();
                  } else if (state is CreditsError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
              BlocConsumer<MoviesBloc, MoviesState>(
                builder: (context, state) => Container(),
                listenWhen: (previous, current) =>
                    current is TrailerSuccess ||
                    current is TrailerError ||
                    current is TrailerLoading,
                listener: (context, state) {
                  if (state is TrailerSuccess) {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) =>
                          YoutubePodPlayer(movieVideo: state.trailer.last),
                    );
                    SystemChrome.setPreferredOrientations([
                      DeviceOrientation.portraitUp,
                    ]);
                    // showModalBottomSheet(
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(12.sp),
                    //       topRight: Radius.circular(12.sp),
                    //     )),
                    //     constraints:
                    //         BoxConstraints(maxHeight: 300.sp, maxWidth: 100.w),
                    //     backgroundColor: colors.primaryDark,
                    //     context: context,
                    //     builder: (context) => Align(
                    //         alignment: Alignment.topCenter,
                    //         child: YoutubePodPlayer(
                    //             movieVideo: state.trailer.last)));
                  } else if (state is TrailerError) {
                    Fluttertoast.showToast(msg: state.message);
                  } else if (state is TrailerLoading) {}
                },
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (previous, current) =>
                    current is RecommendationsSuccess ||
                    current is RecommendationsLoading ||
                    current is RecommendationsError,
                builder: (context, state) {
                  if (state is RecommendationsSuccess) {
                    return MoviesScrollview(
                      isLoading: false,
                      hasMore: false,
                      movieList: state.movieList,
                      moviesType: 'Recommendations',
                      onMovieClick: onMovieClick,
                    );
                  } else if (state is RecommendationsError) {
                    return Container();
                  } else if (state is RecommendationsLoading) {
                    return MoviesScrollview(
                        isLoading: true,
                        hasMore: false,
                        onMovieClick: onMovieClick,
                        movieList: const [],
                        moviesType: "Recommendations");
                  } else {
                    return Container();
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
