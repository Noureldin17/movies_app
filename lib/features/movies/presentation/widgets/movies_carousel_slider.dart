import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
            Padding(padding: EdgeInsets.only(top: 40.sp)),
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
