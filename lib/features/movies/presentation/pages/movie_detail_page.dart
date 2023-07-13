import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:movies_app/features/movies/presentation/widgets/backdrop_image.dart';
import 'package:movies_app/features/movies/presentation/widgets/movie_casts_view.dart';
import 'package:movies_app/features/movies/presentation/widgets/movie_info.dart';
import 'package:movies_app/features/movies/presentation/widgets/pod_video_player.dart';
import 'package:movies_app/utils/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/api/tmdb_api_constants.dart';
import '../../../../utils/colors.dart' as colors;
// import '../../../../utils/pages.dart' as pages;
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
    super.initState();
  }

  static final customCacheManager2 = CacheManager(Config('customPosterKey',
      stalePeriod: const Duration(hours: 5), maxNrOfCacheObjects: 100));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        clipBehavior: Clip.none,
        actions: [],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: isButtonVisible
          ? SizedBox(
              height: 48.sp,
              width: 48.sp,
              child: FloatingActionButton(
                tooltip: "Watch Trailer",
                onPressed: () {
                  BlocProvider.of<MoviesBloc>(context).add(
                      GetTrailerEvent(widget.movieDetailArgs.movie.movieId));
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [colors.primaryBlue, colors.primaryPurple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Center(
                      child: SvgPicture.asset(
                        'assets/icons/video-play.svg',
                        color: Colors.white,
                        width: 18.sp,
                        height: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : null,
      backgroundColor: colors.primaryDark,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            if (!isButtonVisible) {
              setState(() {
                isButtonVisible = true;
              });
            }
          } else if (notification.direction == ScrollDirection.reverse) {
            if (isButtonVisible) {
              setState(() {
                isButtonVisible = false;
              });
            }
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                Hero(
                    tag: widget.movieDetailArgs.movie.backdropPath,
                    child: BackdropImage(
                      sigma: 2,
                      backdropPath:
                          "${TMDBApiConstants.IMAGE_BASE_URL}${widget.movieDetailArgs.movie.backdropPath}",
                    )),
                Padding(
                  padding:
                      EdgeInsets.only(top: 90.sp, left: 12.sp, right: 12.sp),
                  child: Row(
                    children: [
                      Hero(
                        tag: widget.movieDetailArgs.tag,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.sp),
                          child: Image(
                            key: UniqueKey(),
                            height: 125.sp,
                            width: 90.sp,
                            fit: BoxFit.fill,
                            image: CachedNetworkImageProvider(
                              "${TMDBApiConstants.IMAGE_BASE_URL}${widget.movieDetailArgs.movie.posterPath}",
                              cacheManager: customCacheManager2,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 12.sp, top: 10.sp)),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.sp),
                          child: DefaultText.bold(
                              text: widget.movieDetailArgs.movie.movieTitle,
                              fontSize: 18),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
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
                  return Text('data');
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
                } else if (state is CreditsError) {
                  return Text(
                    state.message,
                    style: TextStyle(color: Colors.white),
                  );
                } else {
                  return Text('data');
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
                } else if (state is TrailerLoading) {
                  print("Trailer Loading");
                } else {
                  print('SOMETHING WRONG');
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
