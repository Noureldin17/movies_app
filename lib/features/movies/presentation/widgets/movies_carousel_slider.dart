import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/svg.dart';
// import '../../../../utils/colors.dart' as colors;
import '../../../../utils/default_text.dart';
import 'package:movies_app/features/movies/domain/models/movie_detail_args_model.dart';
import 'package:movies_app/features/movies/domain/models/movie_model.dart';
import 'package:movies_app/features/movies/presentation/widgets/backdrop_image.dart';
import 'package:movies_app/features/movies/presentation/widgets/carousel_slider_image.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/api/tmdb_api_constants.dart';

class MoviesCarouselSlider extends StatefulWidget {
  const MoviesCarouselSlider(
      {super.key, required this.movieList, required this.onMovieClick});
  final List<Movie> movieList;
  final Function onMovieClick;
  @override
  State<MoviesCarouselSlider> createState() => _MoviesCarouselSliderState();
}

class _MoviesCarouselSliderState extends State<MoviesCarouselSlider>
    with WidgetsBindingObserver {
  String backdropPath = '';
  bool animate = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      setState(() {
        animate = false;
      });
    } else if (state == AppLifecycleState.resumed) {
      setState(() {
        animate = true;
      });
    } else if (state == AppLifecycleState.inactive) {
      setState(() {
        animate = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: backdropPath,
          child: backdropPath == ''
              ? BackdropImage(
                  backdropPath: widget.movieList[0].backdropPath,
                  sigma: 15,
                )
              : BackdropImage(backdropPath: backdropPath, sigma: 15),
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(12.sp, 22.sp, 12.sp, 0.sp),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const DefaultText.bold(text: 'Discover', fontSize: 22),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(12.sp))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'See more',
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                            SvgPicture.asset(
                              'assets/icons/arrow-right.svg',
                              height: 12.sp,
                              width: 12.sp,
                              color: Colors.white,
                            )
                          ],
                        )),
                  ]),
            ),
            Padding(padding: EdgeInsets.only(top: 20.sp)),
            CarouselSlider(
                items: [
                  ...widget.movieList.map((movie) => CarouselSliderImage(
                      onClick: () {
                        final movieDetailArgs = MovieDetailArgs(
                            '${movie.posterPath}Discover', movie);
                        widget.onMovieClick(movieDetailArgs);
                      },
                      posterPath: movie.posterPath))
                ],
                options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        backdropPath =
                            '${TMDBApiConstants.IMAGE_BASE_URL}${widget.movieList[index].backdropPath}';
                      });
                    },
                    enlargeCenterPage: true,
                    animateToClosest: true,
                    height: 200.sp,
                    viewportFraction: 0.55,
                    scrollPhysics: const BouncingScrollPhysics(),
                    autoPlay: animate,
                    pageSnapping: true,
                    enableInfiniteScroll: true,
                    autoPlayInterval: const Duration(milliseconds: 7000),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 1500))),
          ],
        ),
      ],
    );
  }
}
