import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/features/movies/domain/models/movie_detail_args_model.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';
import 'package:movies_app/utils/default_text.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;
import '../../../../core/api/tmdb_api_constants.dart';

class MoviesScrollview extends StatefulWidget {
  const MoviesScrollview(
      {super.key,
      required this.movieList,
      required this.moviesType,
      required this.onMovieClick});

  final List<Movie> movieList;
  final String moviesType;
  final Function onMovieClick;

  @override
  State<MoviesScrollview> createState() => _MoviesScrollviewState();
}

class _MoviesScrollviewState extends State<MoviesScrollview> {
  static final customCacheManager = CacheManager(Config('customPosterKey',
      stalePeriod: const Duration(hours: 5), maxNrOfCacheObjects: 100));
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(12.sp, 12.sp, 12.sp, 8.sp),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            DefaultText.bold(text: widget.moviesType, fontSize: 16),
            const Spacer(),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.sp))),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'See more',
                      style: GoogleFonts.roboto(
                          color: colors.primaryDark,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800),
                    ),
                    SvgPicture.asset(
                      'assets/icons/arrow-right.svg',
                      height: 12.sp,
                      width: 12.sp,
                    )
                  ],
                )),
          ]),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...widget.movieList.map((movie) => Padding(
                    padding: EdgeInsets.only(left: 12.sp),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            final movieDetailArgs = MovieDetailArgs(
                              movie.posterPath + widget.moviesType,
                              movie,
                            );
                            widget.onMovieClick(movieDetailArgs);
                          },
                          child: Hero(
                            tag: movie.posterPath + widget.moviesType,
                            child: CachedNetworkImage(
                              // useOldImageOnUrlChange: true,
                              key: UniqueKey(),
                              cacheManager: customCacheManager,
                              imageUrl:
                                  "${TMDBApiConstants.IMAGE_BASE_URL}${movie.posterPath}",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 90.sp,
                                height: 125.sp,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.sp),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.fill)),
                              ),
                              placeholder: (context, url) => Container(
                                width: 90.sp,
                                height: 125.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.sp),
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.sp)),
                        Container(
                          alignment: Alignment.center,
                          width: 90.sp,
                          child: Text(
                            movie.movieTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5.sp)),
                        Container(
                          alignment: Alignment.center,
                          width: 90.sp,
                          child: Text(
                            DateTime.parse(movie.releaseDate).year.toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.roboto(
                                color: colors.primaryGrey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  )),
              Padding(padding: EdgeInsets.only(right: 12.sp))
            ],
          ),
        ),
      ],
    );
  }
}
