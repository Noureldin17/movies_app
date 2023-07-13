import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/core/api/tmdb_api_constants.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';
import 'package:movies_app/features/movies/domain/models/movies_details_model.dart';
import 'package:movies_app/features/movies/presentation/widgets/gradient_divider.dart';
import 'package:movies_app/features/movies/presentation/widgets/movie_description.dart';
import 'package:sizer/sizer.dart';
import '../../../../utils/colors.dart' as colors;

class MovieInfo extends StatefulWidget {
  const MovieInfo({super.key, required this.movieDetails, required this.movie});
  final MovieDetails movieDetails;
  final Movie movie;
  @override
  State<MovieInfo> createState() => _MovieInfoState();
}

class _MovieInfoState extends State<MovieInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(12.sp, 0.sp, 12.sp, 0.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 100.sp,
                child: Column(children: [
                  Text('Produced by',
                      style: GoogleFonts.roboto(
                          fontSize: 10.sp,
                          color: colors.primaryGrey,
                          fontWeight: FontWeight.bold)),
                  Padding(padding: EdgeInsets.only(top: 2.sp)),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(widget.movieDetails.productionCompany,
                        style: GoogleFonts.roboto(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  )
                ]),
              ),
              Column(
                children: [
                  RatingBar.builder(
                    itemSize: 16.sp,
                    unratedColor: Colors.grey,
                    itemBuilder: (context, index) => SvgPicture.asset(
                        'assets/icons/star.svg',
                        color: Colors.yellow),
                    onRatingUpdate: ((value) {}),
                    allowHalfRating: true,
                    ignoreGestures: true,
                    initialRating: (widget.movieDetails.voteAverage * 5) / 10,
                  ),
                  Padding(padding: EdgeInsets.only(top: 2.sp)),
                  Text(
                    'From ${widget.movieDetails.voteCount} users',
                    style: GoogleFonts.roboto(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: colors.primaryGrey),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 16.sp)),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/clock.svg',
                    color: colors.primaryGrey,
                  ),
                  Padding(padding: EdgeInsets.only(left: 6.sp)),
                  Text(
                    '${widget.movieDetails.runtime} minutes',
                    style: GoogleFonts.roboto(
                        color: colors.primaryGrey,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const VerticalDivider(
                color: colors.primaryGrey,
                thickness: 1,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/video-vertical.svg',
                    color: colors.primaryGrey,
                  ),
                  Padding(padding: EdgeInsets.only(left: 6.sp)),
                  Text(
                    widget.movie.genreIds.isEmpty
                        ? 'unknown'
                        : '${TMDBApiConstants.MOVIE_GENRES[widget.movie.genreIds[0]]}',
                    style: GoogleFonts.roboto(
                        color: colors.primaryGrey,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const VerticalDivider(
                color: colors.primaryGrey,
                thickness: 1,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/global.svg',
                    color: colors.primaryGrey,
                  ),
                  Padding(padding: EdgeInsets.only(left: 6.sp)),
                  Text(
                    '${TMDBApiConstants.MOVIE_LANGUAGES[widget.movieDetails.originalLanguage]}',
                    style: GoogleFonts.roboto(
                        color: colors.primaryGrey,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 6.sp)),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset('assets/icons/star-outline.svg',
                          color: colors.primaryGrey)),
                  Text(
                    'Rate',
                    style: GoogleFonts.roboto(
                        color: colors.primaryGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        'assets/icons/archive.svg',
                        color: colors.primaryGrey,
                      )),
                  Text(
                    'Add to List',
                    style: GoogleFonts.roboto(
                        color: colors.primaryGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 10.sp)),
        const GradientDivider(),
        MovieDescription(overview: widget.movieDetails.overview),
      ],
    );
  }
}
