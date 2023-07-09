import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movies_app/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:movies_app/features/movies/presentation/widgets/backdrop_image.dart';
import 'package:movies_app/features/movies/presentation/widgets/movie_casts_view.dart';
import 'package:movies_app/features/movies/presentation/widgets/movie_info.dart';
import 'package:movies_app/utils/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/api/tmdb_api_constants.dart';
import '../../../../utils/colors.dart' as colors;
import '../../domain/models/movie_detail_args_model.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movieDetailArgs});
  final MovieDetailArgs movieDetailArgs;
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
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
      backgroundColor: colors.primaryDark,
      body: SingleChildScrollView(
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
                padding: EdgeInsets.only(top: 90.sp, left: 12.sp, right: 12.sp),
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
                    Padding(padding: EdgeInsets.only(left: 12.sp, top: 10.sp)),
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
        ]),
      ),
    );
  }
}
